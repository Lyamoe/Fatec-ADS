<?php
define("HOST", "localhost");
define("USER", "ROOT");
define("PASSWORD", "");
define("DATABASE", "lista_atividades");
$mysqli = new mysqli(HOST, USER, PASSWORD, DATABASE);

// Verifica a criação do DATABASE
if ($mysqli->connect_errno) {
    echo "<script>console.log('o DATABASE não foi conectado no PHP');</script>";
} else {
    echo "<script>console.log('o DATABASE foi conectado com sucesso');</script>";
}