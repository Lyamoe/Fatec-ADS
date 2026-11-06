<?php
// Caminho de URL para links
define('BASE_URL', 'http://localhost/fatec-ADS/lab-eng-soft/GeloGest/');

// Caminho de pasta/disco para arquivos PHP (servidor)
define('BASE_PATH', __DIR__ . '/../../');

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once BASE_PATH . 'private/config/connect.php';