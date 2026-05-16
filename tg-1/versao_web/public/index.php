<?php
require_once __DIR__ . '/../config/connect.php';
require_once __DIR__ . '/../config/getData.php';
?>

<!DOCTYPE html>
<html lang="PT-BR">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Lyam portfólio</title>

    <!-- //? ==================== CDN ==================== -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

    <!-- //? ==================== OUTROS ==================== -->
    <link rel="stylesheet" href="styles/style.css" />
    <link href="https://fonts.googleapis.com/css2?family=Indie+Flower&family=Bagel+Fat+One&family=Delius&display=swap"
        rel="stylesheet" />
    <link rel="icon" type="image/png" sizes="32x32" href="img/siteIcon.png" />
</head>

<body>
    <!-- //? ==================== HEADER ==================== -->
    <div id="header-container" class="container">
        <header class="row">
            <a class=" fs-4 col-6 logo redish-text" href="#home" onclick="trocarMain('home')">
                <img height="35px" width="35px" src="img/siteIcon.png"
                    alt="Assinatura da Lyam como logo do portfólio" /></a>
            <nav class="col-6" role="navigation">
                <ul class="nav justify-content-end">
                    <li class="nav-item">
                        <a class=" fs-4 nav-link redish-text" target="_blank" rel="noopener noreferrer"
                            aria-label="LinkedIn de Lyam Santos Peres"
                            href="https://www.linkedin.com/in/karine-santos-peres/">
                            <i class="fa-brands fa-linkedin-in"></i>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class=" fs-4 nav-link redish-text" target="_blank" rel="noopener noreferrer"
                            aria-label="Enviar e-mail para Lyam Santos Peres"
                            href="https://mail.google.com/mail/?view=cm&to=karinesanper@gmail.com&su=Contate%20Lyam&body=Eu%20vi%20seu%20portfólio."><i
                                class="fa-solid fa-envelope"></i></a>
                    </li>
                </ul>
            </nav>
        </header>
    </div>
    <!-- //? ==================== Lista ==================== -->
    <main id="projects" class="container w-100">
        <article id="geral-projects" class="row">
                <h1>Atividades</h1>
                <hr class="redish-border-1px" />
                <div class="container">
                    <div id="card-group" class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                        <?php
                        $sql = "SELECT * FROM lista_atividades ORDER BY indice_prioridade DESC";
                        $result = $mysqli->query($sql);
                        if ($result && $result->num_rows > 0):
                            while ($row = $result->fetch_assoc()): ?>
                                <div class="col">
                                    <div class="card flex-fill">
                                        <img src="<?= htmlspecialchars($row['data_atribuicao']) ?>"
                                            class="card-img-top object-fit-cover max-h-25vh" style="max-height: 50vh;"
                                            alt="<?= htmlspecialchars($row['data_entrega']) ?>" />
                                        <div class="card-body">
                                            <h2 class="card-title fs-5 fs-md-4"><?= htmlspecialchars($row['titulo_atividade']) ?></h2>
                                            <p class="card-text fs-6 fs-md-5">
                                                <?= nl2br(htmlspecialchars($row['materia_atividade'])) ?>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <?php
                            endwhile;
                        else:
                            echo "<p>No projects found.</p>";
                        endif;
                        $mysqli->close();
                        ?>

                    </div>
                </div>
        </article>
    </main>
    <!-- //? ==================== FOOTER ==================== -->
    <footer class="text-center">
        <address class="redish-text">
            Portfólio por © Lyamoe <br>
            Entre em contato!
        </address>
    </footer>
    <!-- //? ==================== SCRIPTS ==================== -->
</body>

</html>