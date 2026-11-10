<?php
require_once __DIR__ . '/../../../private/config/generalCallings.php';

$loggedIn = isset($_SESSION['user_id']);
$loginButtonText = $loggedIn ? "Logout" : "Login | Criar Conta";
$loginDestination = BASE_URL . ($loggedIn ? "public/pages/logout.php" : "public/pages/login.php");
?>

<header id="header-container" class="header">
    <a class="header__title" href="<?= BASE_URL ?>public/home.php">GeloGest</a>
    <a class="header__link" href="<?= $loginDestination ?>"><?= $loginButtonText ?></a>
</header>