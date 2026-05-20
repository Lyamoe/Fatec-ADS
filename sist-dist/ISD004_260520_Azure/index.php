<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once 'php/config.php';
require_once 'php/azure_services.php';

// Recupera a mensagem da sessão (se houver) e depois limpa a sessão
$mensagem = isset($_SESSION['mensagem']) ? $_SESSION['mensagem'] : "";
unset($_SESSION['mensagem']);

$tarefas_salvas = [];
$log_exibicao = "Nenhum log gerado ainda.";
date_default_timezone_set('America/Sao_Paulo');

if ($access_key) {
    try {
        // 1. Carrega as tarefas existentes direto da Azure
        $conteudo_atual = baixar_da_azure($account_name, $access_key, $container_name, $blob_tarefas);
        if (!empty($conteudo_atual)) {
            $tarefas_salvas = json_decode($conteudo_atual, true);
        }

        // 2. Carrega os logs existentes direto da Azure para exibir na tela
        $log_salvo = baixar_da_azure($account_name, $access_key, $container_name, $blob_logs);
        if (!empty($log_salvo)) {
            $log_exibicao = $log_salvo;
        }

        // 3. Processa requisições POST (Adicionar, Concluir ou Excluir tarefa)
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $redirecionar = false; // Flag para controlar se precisamos redirecionar
            
            // Lógica para ADICIONAR NOVA TAREFA
            if (!empty($_POST['tarefa'])) {
                $tarefa = htmlspecialchars($_POST['tarefa']);

                $nova_tarefa_estrutura = [
                    'descricao' => $tarefa,
                    'data' => date('d/m/Y H:i:s'),
                    'concluida' => false
                ];
                
                enviar_para_fila_storage($account_name, $access_key, $queue_name, json_encode($nova_tarefa_estrutura));

                $tarefas_salvas[] = $nova_tarefa_estrutura;
                $novo_json_tarefas = json_encode($tarefas_salvas, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
                enviar_para_azure($account_name, $access_key, $container_name, $blob_tarefas, $novo_json_tarefas, "application/json; charset=UTF-8");

                $novo_log = $log_salvo . "Data: " . date('Y-m-d H:i:s') . " | Tarefa adicionada | Conteúdo: " . $tarefa . PHP_EOL;
                enviar_para_azure($account_name, $access_key, $container_name, $blob_logs, $novo_log, "text/plain; charset=UTF-8");

                $_SESSION['mensagem'] = "Tarefa adicionada com sucesso!";
                $redirecionar = true;
            
            // Lógica para MARCAR COMO CONCLUÍDA
            } elseif (isset($_POST['concluir_index'])) {
                $index = (int)$_POST['concluir_index'];
                
                if (isset($tarefas_salvas[$index])) {
                    $tarefas_salvas[$index]['concluida'] = true;
                    
                    $novo_json_tarefas = json_encode($tarefas_salvas, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
                    enviar_para_azure($account_name, $access_key, $container_name, $blob_tarefas, $novo_json_tarefas, "application/json; charset=UTF-8");
                    
                    $descricao_concluida = $tarefas_salvas[$index]['descricao'];
                    $novo_log = $log_salvo . "Data: " . date('Y-m-d H:i:s') . " | Tarefa Concluída: " . $descricao_concluida . PHP_EOL;
                    enviar_para_azure($account_name, $access_key, $container_name, $blob_logs, $novo_log, "text/plain; charset=UTF-8");
                    
                    $_SESSION['mensagem'] = "Tarefa '{$descricao_concluida}' marcada como concluída!";
                    $redirecionar = true;
                }

            // Lógica para EXCLUIR TAREFA
            } elseif (isset($_POST['excluir_index'])) {
                $index = (int)$_POST['excluir_index'];
                
                if (isset($tarefas_salvas[$index])) {
                    $descricao_excluida = $tarefas_salvas[$index]['descricao'];
                    
                    array_splice($tarefas_salvas, $index, 1);
                    
                    $novo_json_tarefas = json_encode($tarefas_salvas, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
                    enviar_para_azure($account_name, $access_key, $container_name, $blob_tarefas, $novo_json_tarefas, "application/json; charset=UTF-8");
                    
                    $novo_log = $log_salvo . "Data: " . date('Y-m-d H:i:s') . " | Tarefa Excluída: " . $descricao_excluida . PHP_EOL;
                    enviar_para_azure($account_name, $access_key, $container_name, $blob_logs, $novo_log, "text/plain; charset=UTF-8");
                    
                    $_SESSION['mensagem'] = "Tarefa '{$descricao_excluida}' excluída com sucesso!";
                    $redirecionar = true;
                }
            }

            // Se alguma ação POST foi executada, redireciona para limpar o envio do formulário
            if ($redirecionar) {
                header("Location: " . $_SERVER['PHP_SELF']);
                exit;
            }
        }
    } catch (Exception $e) {
        $mensagem = "ERRO REAL: " . $e->getMessage();
    }
} else {
    $mensagem = "Aviso: AZURE_STORAGE_KEY não configurada nas Application Settings.";
}

require_once 'php/view.php';