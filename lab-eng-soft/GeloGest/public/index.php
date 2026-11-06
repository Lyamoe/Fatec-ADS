<?php
require_once __DIR__ . '/../private/config/generalCallings.php';
require_once BASE_PATH . 'private/config/getData.php';

$companyName = getCompanyName();
$headingText = !empty($companyName)
    ? "Acompanhe o estoque da " . htmlspecialchars($companyName, ENT_QUOTES, 'UTF-8') . "!"
    : "Acompanhe seu estoque com GeloGest!";

$loggedIn = isset($_SESSION['user_id']);

// Fetch user type from session (defaults to 'guest' if not logged in)
$userType = $_SESSION['user_type'] ?? 'guest';
$isOwnerOrAdmin = in_array($userType, ['admin', 'owner'], true);

// Set page metadata
$pageTitle = "GeloGest | Sistema de Gestão de Estoque para Gelaterias";
$metaDescription = "GeloGest é a plataforma completa para controle de estoque, gestão de cubas e controle diário para sorveterias e gelaterias.";
?>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <!-- Core SEO Meta Tags -->
    <title><?= htmlspecialchars($pageTitle, ENT_QUOTES, 'UTF-8') ?></title>
    <meta name="description" content="<?= htmlspecialchars($metaDescription, ENT_QUOTES, 'UTF-8') ?>" />
    <meta name="robots" content="index, follow" />
    <link rel="canonical" href="https://gelogest.infinityfreeapp.com" />

    <!-- Open Graph (Facebook / WhatsApp / LinkedIn preview) -->
    <meta property="og:type" content="website" />
    <meta property="og:title" content="<?= htmlspecialchars($pageTitle, ENT_QUOTES, 'UTF-8') ?>" />
    <meta property="og:description" content="<?= htmlspecialchars($metaDescription, ENT_QUOTES, 'UTF-8') ?>" />
    <meta property="og:image" content="https://gelogest.infinityfreeapp.com/img/og-preview.png" />

    <!-- Assets -->
    <link rel="icon" type="image/png" sizes="32x32" href="img/siteIcon.png" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+Condensed:ital,wght@0,100;0,400;0,700;1,400&family=Lilita+One&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="styles/css/index.css" />
</head>

<body class="body">
    <?php require_once BASE_PATH . 'public/pages/includes/header.php'; ?>

    <main id="home" class="main">
        <div class="hero">
            <h1 class="hero__title"><?= $headingText ?></h1>
            <p class="hero__subtitle">Sistema de gestão de estoques para gelaterias</p>
        </div>

        <section class="options">
            <h2 class="options__title">Ações Rápidas</h2>

            <div class="options__buttons" aria-label="Ações Rápidas de Estoque">
                <?php if ($isOwnerOrAdmin): ?>
                    <a class="options__button" href="pages/dashboard.php">
                        <span>Dashboard</span>
                        <span class="options__desc">Análise de desempenho da empresa</span>
                    </a>
                    <a class="options__button" href="pages/gerenciar-usuarios.php">
                        <span>Gerenciar usuários</span>
                        <span class="options__desc">Adicionar, editar e remover usuários</span>
                    </a>
                <?php else: ?>
                    <a class="options__button" href="pages/novo-estoque.php">
                        <span>Novo estoque</span>
                        <span class="options__desc">Chegada de produtos ao estoque</span>
                    </a>
                    <a class="options__button" href="pages/estoque-diario.php">
                        <span>Estoque diário</span>
                        <span class="options__desc">Atualização diária das quantidades</span>
                    </a>
                <?php endif; ?>
                <a class="options__button" href="pages/consulta-estoque.php">
                    <span>Consultar estoque</span>
                    <span class="options__desc">Conferir estoque em um período</span>
                </a>
            </div>
        </section>
    </main>

    <?php require_once BASE_PATH . 'public/pages/includes/footer.php'; ?>
</body>

</html>