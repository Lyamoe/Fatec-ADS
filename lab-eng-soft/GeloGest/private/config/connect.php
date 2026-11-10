<?php
define("HOST", "localhost");
define("USER", "root");
define("PASSWORD", "");
define("DATABASE", "if0_43255295_gelogest");

// define("HOST", "sql103.infinityfree.com");
// define("USER", "if0_43255295");
// define("PASSWORD", "glgMilane1213");
// define("DATABASE", "if0_43255295_gelogest");

$conn = new mysqli(HOST, USER, PASSWORD, DATABASE);

// Verifica a criação do DATABASE
if ($conn->connect_errno) {
    echo "<script>console.log('o DATABASE não foi conectado no PHP');</script>";
} else {
    echo "<script>console.log('o DATABASE foi conectado com sucesso');</script>";
}