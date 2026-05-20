<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minha Lista de Tarefas Azure</title>
    <link rel="stylesheet" href="../styles/css/style.css">
</head>

<body>
    <header>
        <h1>LISTA DE TAREFAS</h1>
        <p class="subtitle">Seminário de Sistemas Distribuídos</p>
    </header>
    <main class="container">
        <?php if ($mensagem): ?>
            <div class="status-msg <?php echo (strpos($mensagem, 'ERRO') !== false) ? 'erro-alerta' : 'sucesso-alerta'; ?>">
                <?php echo $mensagem; ?>
            </div>
        <?php endif; ?>

        <form method="POST" class="todo-form">
            <input type="text" name="tarefa" class="todo-input" placeholder="Ex: Estudar matemática" required>
            <button type="submit" class="btn-add">Adicionar tarefa</button>
        </form>

        <h2>Minhas Tarefas</h2>
        <?php if (!empty($tarefas_salvas)): ?>
            <ul>
                <?php foreach ($tarefas_salvas as $index => $item): ?>
                    <?php
                    $is_concluida = isset($item['concluida']) && $item['concluida'] === true;
                    ?>
                    <li class="<?php echo $is_concluida ? 'tarefa-concluida' : ''; ?>">
                        <div class="tarefa-texto">
                            <strong><?php echo $item['descricao']; ?></strong>
                            <small>Enviado em: <?php echo $item['data']; ?></small>
                        </div>

                        <div class="acoes">
                            <?php if (!$is_concluida): ?>
                                <form method="POST" style="margin: 0;">
                                    <input type="hidden" name="concluir_index" value="<?php echo $index; ?>">
                                    <button type="submit" class="btn-action btn-concluir"
                                        title="Marcar como concluída">Concluir</button>
                                </form>
                            <?php endif; ?>

                            <form method="POST" style="margin: 0;"
                                onsubmit="return confirm('Tem certeza que deseja excluir esta tarefa?');">
                                <input type="hidden" name="excluir_index" value="<?php echo $index; ?>">
                                <button type="submit" class="btn-action btn-excluir" title="Excluir tarefa">Excluir</button>
                            </form>
                        </div>
                    </li>
                <?php endforeach; ?>
            </ul>
        <?php else: ?>
            <div class="empty-state">
                <p>Nenhuma tarefa pendente encontrada no JSON do Blob Storage.</p>
            </div>
        <?php endif; ?>

        <div class="log-container">
            <h2>Logs Recentes</h2>
            <pre><?php echo htmlspecialchars($log_exibicao); ?></pre>
        </div>
    </main>
</body>

</html>