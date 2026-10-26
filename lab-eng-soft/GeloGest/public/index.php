<?php
// require_once __DIR__ . '/../private/config/connect.php';
// require_once __DIR__ . '/../private/config/getData.php';
?>

<!DOCTYPE html>
<html lang="PT-BR">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>GeloGest</title>

    <!-- //* ==================== CDN ==================== -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

    <!-- //* ==================== OUTROS ==================== -->
    <link rel="stylesheet" href="styles/css/index.css" />
    <link href="https://fonts.googleapis.com/css2?family=Indie+Flower&family=Bagel+Fat+One&family=Delius&display=swap"
        rel="stylesheet" />
    <link rel="icon" type="image/png" sizes="32x32" href="img/siteIcon.png" />
</head>

<body>
    <!-- //* ==================== HEADER ==================== -->
    <header id="header-container" class="header">
        <p class="header__title">GeloGest</p>
        <a class="header__link" href="pages/login.php">Login</a>
    </header>
    <!-- //* ==================== MAIN ==================== -->
    <main id="home" class="">
        <h1>GeloGest</h1>
        <p>Sistema de gestão de estoque de gelateria</p>

        <section class="buttons">
            <a href="pages/novo-estoque.php">Novo estoque</a>
            <a href="pages/estoque-diario.php">Estoque diário</a>
            <a href="pages/consulta-estoque.php">Consultar estoque</a>
            <a href="pages/dashboard.php" class="perm-admin">Dashboard</a>
        </section>
    </main>

    <!-- //* ==================== FOOTER ==================== -->
    <footer class="">
        <address class="">
            © GeloGest
        </address>
    </footer>
    <!-- //* ==================== SCRIPTS ==================== -->
    
</body>

</html>