<?php
$mensagem = "";
$tarefas_salvas = [];
$log_exibicao = "Nenhum log gerado ainda.";

// 1. Configurações do Azure Blob Storage
$account_name = getenv('AZURE_STORAGE_ACCOUNT') ?: "listatarefaslog";
$access_key = getenv('AZURE_STORAGE_KEY');
$container_name = "logs";

$blob_tarefas = "lista_de_tarefas.json";
$blob_logs = "logs_projeto.txt";

function enviar_para_azure($account_name, $access_key, $container, $blob, $conteudo, $content_type)
{
    $date = gmdate('D, d M Y H:i:s \G\M\T');
    $version = "2019-12-12"; // Força o Azure a usar um padrão de API fixo e moderno
    $destination_url = "https://{$account_name}.blob.core.windows.net/{$container}/{$blob}";
    $content_length = strlen($conteudo);

    // Montagem usando chr(10) que garante a quebra de linha do Linux em qualquer sistema
    $string_to_sign = "PUT" . chr(10) .              // Verbo
        "" . chr(10) .                 // Content-Encoding
        "" . chr(10) .                 // Content-Language
        $content_length . chr(10) .    // Content-Length
        "" . chr(10) .                 // Content-MD5
        $content_type . chr(10) .      // Content-Type
        "" . chr(10) .                 // Date
        "" . chr(10) .                 // If-Modified-Since
        "" . chr(10) .                 // If-Match
        "" . chr(10) .                 // If-None-Match
        "" . chr(10) .                 // If-Unmodified-Since
        "" . chr(10) .                 // Range
        "x-ms-blob-type:BlockBlob" . chr(10) .
        "x-ms-date:" . $date . chr(10) .
        "x-ms-version:" . $version . chr(10) . // Incluído na assinatura
        "/" . $account_name . "/" . $container . "/" . $blob;

    // Codifica a assinatura
    $signature = base64_encode(hash_hmac('sha256', $string_to_sign, base64_decode($access_key), true));

    $headers = [
        "Host: {$account_name}.blob.core.windows.net",
        "x-ms-date: {$date}",
        "x-ms-version: {$version}", // Obrigatório enviar junto no cabeçalho
        "x-ms-blob-type: BlockBlob",
        "Authorization: SharedKey {$account_name}:{$signature}",
        "Content-Type: {$content_type}",
        "Content-Length: " . $content_length
    ];

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $destination_url);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
    curl_setopt($ch, CURLOPT_POSTFIELDS, $conteudo);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    $resposta = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($http_code !== 201) {
        throw new Exception("Erro no Azure Storage (HTTP {$http_code}): " . htmlspecialchars($resposta));
    }
    return true;
}

function baixar_da_azure($account_name, $access_key, $container, $blob)
{
    $date = gmdate('D, d M Y H:i:s \G\M\T');
    $version = "2019-12-12";
    $destination_url = "https://{$account_name}.blob.core.windows.net/{$container}/{$blob}";

    // Montagem estrita para o GET com a versão da API
    $string_to_sign = "GET" . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) .
        "x-ms-date:" . $date . chr(10) .
        "x-ms-version:" . $version . chr(10) .
        "/" . $account_name . "/" . $container . "/" . $blob;

    $signature = base64_encode(hash_hmac('sha256', $string_to_sign, base64_decode($access_key), true));

    $headers = [
        "x-ms-date: {$date}",
        "x-ms-version: {$version}",
        "Authorization: SharedKey {$account_name}:{$signature}"
    ];

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $destination_url);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $resultado = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    return ($http_code == 200) ? $resultado : "";
}

// --- FLUXO PRINCIPAL ---
if ($access_key) {
    try {
        // 1. Carrega as tarefas existentes direto da Azure 
        $conteudo_atual = baixar_da_azure($account_name, $access_key, $container_name, $blob_tarefas);
        if (!empty($conteudo_atual)) {
            $tarefas_salvas = json_decode($conteudo_atual, true) ?: [];
        }

        // 2. Carrega os logs existentes direto da Azure para exibir na tela
        $log_salvo = baixar_da_azure($account_name, $access_key, $container_name, $blob_logs);
        if (!empty($log_salvo)) {
            $log_exibicao = $log_salvo;
        }

        // 3. Processa o envio do formulário 
        if ($_SERVER['REQUEST_METHOD'] == 'POST' && !empty($_POST['tarefa'])) {
            $tarefa = htmlspecialchars($_POST['tarefa']);

            // Persistência de Dados
            $tarefas_salvas[] = [
                'descricao' => $tarefa,
                'data' => date('d/m/Y H:i:s')
            ];
            $novo_json_tarefas = json_encode($tarefas_salvas, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);

            // Tenta enviar as tarefas
            enviar_para_azure($account_name, $access_key, $container_name, $blob_tarefas, $novo_json_tarefas, "application/json; charset=UTF-8");

            // Tenta enviar os logs
            $novo_log = $log_salvo . "Data: " . date('Y-m-d H:i:s') . " | Tarefa Adicionada: " . $tarefa . PHP_EOL;
            enviar_para_azure($account_name, $access_key, $container_name, $blob_logs, $novo_log, "text/plain; charset=UTF-8");

            $log_exibicao = $novo_log;
            $mensagem = "Sucesso: Tarefa '{$tarefa}' salva de verdade no Azure Blob Storage!";
        }
    } catch (Exception $e) {
        // Se a API do Azure recusar a chave ou a rede bloquear, o erro estoura aqui em vermelho
        $mensagem = "ERRO REAL: " . $e->getMessage();
    }
} else {
    $mensagem = "Aviso: AZURE_STORAGE_KEY não configurada nas Application Settings.";
}
?>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>Minha Lista de Tarefas Azure</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 50px;
            line-height: 1.6;
        }

        .status-msg {
            padding: 10px;
            margin-bottom: 15px;
            font-weight: bold;
            border-radius: 4px;
        }

        .erro-alerta {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .sucesso-alerta {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        ul {
            list-style-type: square;
            padding-left: 20px;
        }

        li {
            margin-bottom: 5px;
        }
    </style>
</head>

<body>
    <h1>📝 To-do List - Azure Students</h1>

    <?php if ($mensagem): ?>
        <div class="status-msg <?php echo (strpos($mensagem, 'ERRO') !== false) ? 'erro-alerta' : 'sucesso-alerta'; ?>">
            <?php echo $mensagem; ?>
        </div>
    <?php endif; ?>

    <form method="POST">
        <input type="text" name="tarefa" placeholder="Ex: Estudar Azure Policy" required>
        <button type="submit">Adicionar Tarefa</button>
    </form>

    <h3>Minhas Tarefas na Nuvem:</h3>
    <?php if (!empty($tarefas_salvas)): ?>
        <ul>
            <?php foreach ($tarefas_salvas as $item): ?>
                <li><strong><?php echo $item['descricao']; ?></strong> <small>(Adicionado em:
                        <?php echo $item['data']; ?>)</small></li>
            <?php endforeach; ?>
        </ul>
    <?php else: ?>
        <p>Nenhuma tarefa pendente no JSON.</p>
    <?php endif; ?>

    <h3>Logs do Sistema:</h3>
    <pre style="background: #eee; padding: 10px;"><?php echo htmlspecialchars($log_exibicao); ?></pre>
</body>

</html>