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

    <body class="d-flex justify-content-center align-items-center vh-100">
        <form action="../../private/config/loginHandler.php" method="POST" class="p-4 rounded shadow login-form green-text-box container">
            <h2 class="text-center mb-4">Login</h2>

            <div class="mb-3">
                <label for="username" class="form-label redish-text">Username</label>
                <input type="text" name="username" id="username" class="form-control" required />
            </div>

            <div class="mb-3">
                <label for="password" class="form-label redish-text">Password</label>
                <input type="password" name="password" id="password" class="form-control" required />
            </div>

            <button type="submit" name="login-submit" class="btn btn-success w-100">Login</button>
        </form>

        <script src="../../private/config/js/showDebug.js"></script>
    </body>


    </html>
    <?php
}
?>