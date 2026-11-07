<?php
require_once __DIR__ . '/../../private/config/generalCallings.php';

if (isset($_SESSION['user_id']) && isset($_SESSION['user_name'])) {
    header("Location: ../index.php");
    exit();
} else {
    //* ========== Set page metadata
    $pageTitle = "Consultar estoque | GeloGest";
    $metaDescription = "Acompanhe o estoque da sua empresa de forma prática e eficiente com o GeloGest.";
    ?>

    <!DOCTYPE html>
    <html lang="pt-BR">

    <head>

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <!-- //*  Core SEO Meta Tags -->
        <title><?= $pageTitle ?></title>
        <meta name="description" content="<?= $metaDescription ?>" />
        <meta name="robots" content="index, follow" />
        <link rel="canonical" href="https://gelogest.infinityfreeapp.com" />

        <!-- //*  Open Graph (Facebook / WhatsApp / LinkedIn preview) -->
        <meta property="og:type" content="website" />
        <meta property="og:title" content="<?= $pageTitle ?>" />
        <meta property="og:description" content="<?= $metaDescription ?>" />
        <meta property="og:image" content="https://gelogest.infinityfreeapp.com/img/og-preview.png" />
        <!-- //* ========== todo: update to actual picture -->

        <!-- //*  Assets -->
        <link rel="icon" type="image/png" sizes="32x32" href="img/siteIcon.png" />
        <!-- //* ========== todo: update to actual picture -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+Condensed:ital,wght@0,100;0,400;0,700;1,400&family=Lilita+One&display=swap"
            rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="<?php echo BASE_URL; ?>public/styles/css/login.css" />
    </head>

    <body class="body">
        <?php require_once BASE_PATH . 'public/pages/includes/header.php'; ?>

        <main class="main">
            <form class="login-form" action="<?php echo BASE_URL; ?>private/config/loginHandler.php" method="POST">
                <h2 class="login-form__title">Entre na sua conta</h2>

                <div class="login-form__field">
                    <label class="login-form__label" for="username">Nome de usuário</label>
                    <input class="login-form__input" type="text" name="username" id="username" required />
                </div>

                <div class="login-form__field">
                    <label class="login-form__label" for="password">Password</label>
                    <input class="login-form__input" type="password" name="password" id="password" required />
                </div>

                <button class="login-form__submit" type="submit" name="login-submit">Login</button>

                <a class="login-form__create-account" href="criar-conta-empresa.php">Criar conta para minha empresa</a>
            </form>

        </main>

        <?php require_once BASE_PATH . 'public/pages/includes/footer.php'; ?>

        <script src="<?php echo BASE_URL; ?>public/js/showLoginError.js"></script>
    </body>

    </html>
    <?php
}
?>