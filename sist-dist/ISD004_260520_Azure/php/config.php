<?php
$account_name = getenv('AZURE_STORAGE_ACCOUNT') ?: "listatarefaslog";
$access_key = getenv('AZURE_STORAGE_KEY');
$container_name = "logs";

$blob_tarefas = "lista_de_tarefas.json";
$blob_logs = "logs_projeto.txt";
$queue_name = "fila-tarefas";