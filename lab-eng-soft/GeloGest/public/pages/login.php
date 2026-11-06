<?php
session_start();
require_once __DIR__ . '/../../private/config/loginHandler.php';

if (isset($_SESSION['user_id']) && isset($_SESSION['user_name'])) {
    header("Location:../index.php");
    exit();
} else {
    ?>

    <!DOCTYPE html>
    <html lang="pt-BR">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Login to edit portfolio</title>
        <!--? ==================== CDN ==================== -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

        <!--? ==================== OUTROS ==================== -->
        <link rel="stylesheet" href="styles/style.css" />
        <link href="https://fonts.googleapis.com/css2?family=Indie+Flower&family=Bagel+Fat+One&family=Delius&display=swap"
            rel="stylesheet" />
        <link rel="icon" type="image/png" sizes="32x32" href="../img/siteIcon.png" />
    </head>

    <body>
        <form action="../../private/config/loginHandler.php" method="POST">
            <h2>Login</h2>

            <div>
                <label for="username">Username</label>
                <input type="text" name="username" id="username" required />
            </div>

            <div>
                <label for="password">Password</label>
                <input type="password" name="password" id="password" required />
            </div>

            <button type="submit" name="login-submit">Login</button>
        </form>

        <a href="criar-conta-empresa.php">Criar conta para minha empresa</a>

        <script src="<?php echo BASE_URL; ?>public/js/showLoginError.js"></script>
    </body>

    </html>
    <?php
}
?>