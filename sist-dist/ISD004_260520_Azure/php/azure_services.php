<?php
function enviar_para_fila_storage($account_name, $account_key, $queue_name, $conteudo_mensagem)
{
    // O Azure Queue Storage exige que o conteúdo esteja em formato XML específico e codificado em Base64
    $mensagem_base64 = base64_encode($conteudo_mensagem);
    $xml_body = "<QueueMessage><MessageText>{$mensagem_base64}</MessageText></QueueMessage>";
    
    $date = gmdate('D, d M Y H:i:s \G\M\T');
    $version = "2021-08-06"; // Versão estável da API de filas
    
    $destination_url = "https://{$account_name}.queue.core.windows.net/{$queue_name}/messages";
    $content_length = strlen($xml_body);

    // Montagem estrita da String to Sign do Queue Storage
    $canonicalized_resource = "/{$account_name}/{$queue_name}/messages";
    $string_to_sign = "POST" . chr(10) .
        "" . chr(10) . // Content-Encoding
        "" . chr(10) . // Content-Language
        $content_length . chr(10) . // Content-Length
        "" . chr(10) . // Content-MD5
        "application/xml" . chr(10) . // Content-Type
        "" . chr(10) . // Date
        "" . chr(10) . // If-Modified-Since
        "" . chr(10) . // If-Match
        "" . chr(10) . // If-None-Match
        "" . chr(10) . // If-Unmodified-Since
        "" . chr(10) . // Range
        "x-ms-date:" . $date . chr(10) .
        "x-ms-version:" . $version . chr(10) .
        $canonicalized_resource;

    $signature = base64_encode(hash_hmac('sha256', $string_to_sign, base64_decode($account_key), true));

    $headers = [
        "Host: {$account_name}.queue.core.windows.net",
        "x-ms-date: {$date}",
        "x-ms-version: {$version}",
        "Authorization: SharedKey {$account_name}:{$signature}",
        "Content-Type: application/xml",
        "Content-Length: " . $content_length
    ];

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $destination_url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $xml_body);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    $resposta = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);

    // O Azure retorna HTTP 201 quando a mensagem é postada com sucesso na fila
    if ($http_code !== 201) {
        throw new Exception("Erro no Queue Storage (HTTP {$http_code}): " . htmlspecialchars($resposta));
    }
    return true;
}

// --- FUNÇÕES COMPLEMENTARES DO BLOB STORAGE ---
function enviar_para_azure($account_name, $access_key, $container, $blob, $conteudo, $content_type)
{
    $date = gmdate('D, d M Y H:i:s \G\M\T');
    $version = "2019-12-12"; 
    $destination_url = "https://{$account_name}.blob.core.windows.net/{$container}/{$blob}";
    $content_length = strlen($conteudo);

    $string_to_sign = "PUT" . chr(10) . "" . chr(10) . "" . chr(10) . $content_length . chr(10) . "" . chr(10) . $content_type . chr(10) . "" . chr(10) . "" . chr(10) . "" . chr(10) . "" . chr(10) . "" . chr(10) . "" . chr(10) . "x-ms-blob-type:BlockBlob" . chr(10) . "x-ms-date:" . $date . chr(10) . "x-ms-version:" . $version . chr(10) . "/" . $account_name . "/" . $container . "/" . $blob;

    $signature = base64_encode(hash_hmac('sha256', $string_to_sign, base64_decode($access_key), true));

    $headers = [
        "Host: {$account_name}.blob.core.windows.net",
        "x-ms-date: {$date}",
        "x-ms-version: {$version}", 
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

    if ($http_code !== 201) {
        throw new Exception("Erro no Azure Storage Blob (HTTP {$http_code}): " . htmlspecialchars($resposta));
    }
    return true;
}

function baixar_da_azure($account_name, $access_key, $container, $blob)
{
    $date = gmdate('D, d M Y H:i:s \G\M\T');
    $version = "2019-12-12";
    $destination_url = "https://{$account_name}.blob.core.windows.net/{$container}/{$blob}";

    $string_to_sign = "GET" . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . chr(10) . "x-ms-date:" . $date . chr(10) . "x-ms-version:" . $version . chr(10) . "/" . $account_name . "/" . $container . "/" . $blob;

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

    return ($http_code == 200) ? $resultado : "";
}