<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$loggedIn = isset($_SESSION['user_id']);
$loginButtonText = $loggedIn ? "Logout" : "Login";
$loginDestination = $loggedIn ? "pages/logout.php" : "pages/login.php";
?>

<header id="header-container" class="header">
    <p class="header__title">GeloGest</p>
    <a class="header__link" href="<?= $loginDestination ?>"><?= $loginButtonText ?></a>
</header>