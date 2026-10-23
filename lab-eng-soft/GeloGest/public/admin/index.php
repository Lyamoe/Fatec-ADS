<?php
require_once __DIR__ . '/../../private/config/connect.php';
require_once __DIR__ . '/../../private/config/getData.php';

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
if (!isset($_SESSION['user_id']) || !isset($_SESSION['user_name'])) {
    header("Location:login.php");
    exit();
} else {
    ?>
    <!DOCTYPE html>
    <html lang="pt-BR">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Portfolio control</title>
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

    <body class="container justify-content-center">
        <header class="row mb-5 align-items-center">
            <h1 class="col-10">Edit Painel for Lyam's Portfolio</h1>
            <a id="logout" class="col-2 fs-3 text-decoration-none redish-text" href="logout.php">Logout</a>
        </header>
        <main class="edit-group">
            <h2 class="card-title mb-4 text-center">Home Config</h2>
            <section class="form-group">
                <form action="../../private/config/sendData.php" method="post" enctype="multipart/form-data" class="text-center">
                    <label for="title" class="form-label">Main Title</label>
                    <div class="btn-group">
                        <input type="text" name="title" id="title" class="form-control"
                            placeholder="Current: <?php echo htmlspecialchars(getDbInfo(0, 0)); ?>" />
                        <button type="submit" name="title-submit" class="w-50">
                            &#10003
                        </button>
                    </div>
                </form>
                <hr>
                <form action="../../private/config/sendData.php" method="post" enctype="multipart/form-data" class="text-center">
                    <label for="subtitle" class="form-label mt-3">Main Subtitle</label>
                    <div class="btn-group">
                        <input type="text" name="subtitle" id="subtitle" class="form-control"
                            placeholder="Current: <?php echo htmlspecialchars(getDbInfo(1, 0)); ?>" />
                        <button type="submit" name="subtitle-submit" class="w-50">
                            &#10003
                        </button>
                    </div>
                </form>
            </section>

            <h2 class="card-title mb-4 text-center mt-4">About config</h2>
            <section class="form-group">
                <form action="../../private/config/sendData.php" method="post" enctype="multipart/form-data" class="text-center">
                    <label for="self-desc" class="form-label mt-3">Description about yourself</label>
                    <div class="btn-group">
                        <textarea name="self-desc" id="self-desc" class="form-control"
                            placeholder="Current: <?php echo htmlspecialchars(getDbInfo(2, 1)); ?>">
                                    </textarea>
                        <button type="submit" name="self-desc-submit" class="w-50">
                            &#10003
                        </button>
                    </div>
                </form>
                <hr>
                <form action="../../private/config/sendData.php" method="post" enctype="multipart/form-data" class="text-center">
                    <label for="profile-picture" class="form-label mt-3">An image that represents you</label>
                    <input type="file" name="profile-picture" id="profile-picture" class="form-control w-100-input" />
                    <label for="pfp-alt" class="form-label mt-3">Alt text of the pfp</label>
                    <input type="text" name="pfp-alt" id="pfp-alt" class="form-control w-100-input"
                        placeholder="Current: <?php echo htmlspecialchars(getDbInfo(4, 1)); ?>">
                    <button type="submit" name="pfp-submit" class="w-50 confirm">
                        Confirm
                    </button>
                </form>
                <hr>
                <form action="../../private/config/sendData.php" method="post" enctype="multipart/form-data" class="text-center">
                    <label for="profile-banner" class="form-label mt-3">An image for your banner</label>
                    <input type="file" name="profile-banner" id="profile-banner" class="form-control w-100-input" />
                    <label for="banner-alt" class="form-label mt-3">Alt text of the banner</label>
                    <input type="text" name="banner-alt" id="banner-alt" class="form-control w-100-input"
                        placeholder="Current: <?php echo htmlspecialchars(getDbInfo(6, 1)); ?>">
                    <button type="submit" name="profile-banner-submit" class="w-50 confirm">
                        Confirm
                    </button>
                </form>
            </section>

            <h2 class="card-title mb-4 text-center my-4">Add new project</h2>
            <section class="form-group">
                <form action="../../private/config/sendData.php" method="post" enctype="multipart/form-data" class="text-center">
                    <label for="project-name" class="form-label mt-3">Name of the project</label>
                    <input type="text" name="project-name" id="project-name" class="form-control w-100-input"
                        placeholder="Ex: super duper fun game" required />
                    <label for="project-description" class="form-label mt-3">Description of the project</label>
                    <input type="text" name="project-description" id="project-description" class="form-control w-100-input"
                        placeholder="What it is about, what you did" required />
                    <label for="project-banner" class="form-label mt-3">A banner of the project</label>
                    <input type="file" name="project-banner" id="project-banner" class="form-control w-100-input"
                        required />
                    <label for="project-banner-alt" class="form-label mt-3">Alt text of the banner</label>
                    <input type="text" name="project-banner-alt" id="project-banner-alt" class="form-control w-100-input"
                        placeholder="Something like 'game homescreen'" />
                    <button type="submit" name="projects-submit" class="w-50 confirm">
                        Confirm
                    </button>
                </form>
                <div class="text-center mt-4">
                    <a href="editProjects.php" class="btn btn-secondary">Edit Existing Projects</a>
                </div>
            </section>
        </main>
        <script src="../../private/config/js/showDebug.js"></script>
    </body>

    </html>
    <?php
}
?>