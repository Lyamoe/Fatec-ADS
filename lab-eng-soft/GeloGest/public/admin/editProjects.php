<?php
require_once __DIR__ . '/../../private/config/connect.php';
require_once __DIR__ . '/../../private/config/sendData.php';
require_once __DIR__ . '/../../private/config/sqlFields.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['delete_id'])) {
        $id = intval($_POST['delete_id']);
        $mysqli->query("DELETE FROM projects WHERE id = $id");
        header("Location: index.php?deleted=1");
        exit;
    }

    if (isset($_POST['edit_id']) && isset($_POST['projects'][$_POST['edit_id']])) {
        $id = intval($_POST['edit_id']);
        $project = $_POST['projects'][$id];

        $name = $mysqli->real_escape_string($project['game_name']);
        $desc = $mysqli->real_escape_string($project['game_desc']);
        $alt = $mysqli->real_escape_string($project['game_banner_alt']);

        if (isset($_FILES['project_banners']['name'][$id]) && $_FILES['project_banners']['error'][$id] == 0) {
            $file = [
                'name' => $_FILES['project_banners']['name'][$id],
                'type' => $_FILES['project_banners']['type'][$id],
                'tmp_name' => $_FILES['project_banners']['tmp_name'][$id],
                'error' => $_FILES['project_banners']['error'][$id],
                'size' => $_FILES['project_banners']['size'][$id]
            ];
            $relativePath = uploadFile($file, $sqlTables[2], $sqlFields[9], null, true);

            $mysqli->query("UPDATE projects SET 
                game_name='$name', 
                game_desc='$desc', 
                game_banner='$relativePath', 
                game_banner_alt='$alt' 
                WHERE id=$id");
        } else {
            $mysqli->query("UPDATE projects SET 
                game_name='$name', 
                game_desc='$desc', 
                game_banner_alt='$alt' 
                WHERE id=$id");
        }
        header("Location: index.php?success=2");
        exit;
    }
}


$result = $mysqli->query("SELECT * FROM projects");
if (!$result) {
    error_log("Erro ao buscar projetos: " . $mysqli->error);
    header("Location: index.php?fail=11");
    exit;
}
?>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <title>Editar Projetos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function confirmDelete() {
            return confirm('Tem certeza que quer deletar este projeto? Essa ação não pode ser desfeita.');
        }
    </script>
</head>

<body class="bg-light p-4">

    <div class="container">
        <h1 class="mb-4">Editar Projetos</h1>
        <?php while ($row = $result->fetch_assoc()): ?>
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <strong>Projeto ID <?= $row['id'] ?>: <?= htmlspecialchars($row['game_name']) ?></strong>

                    <!-- Form de deletar -->
                    <form method="POST" onsubmit="return confirmDelete();" class="d-inline">
                        <input type="hidden" name="delete_id" value="<?= $row['id'] ?>">
                        <button type="submit" class="btn btn-sm btn-danger">Deletar</button>
                    </form>
                </div>

                <!-- Form de edição -->
                <form method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="edit_id" value="<?= $row['id'] ?>">

                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label">Nome:</label>
                            <input type="text" class="form-control" name="projects[<?= $row['id'] ?>][game_name]"
                                value="<?= htmlspecialchars($row['game_name']) ?>" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Descrição:</label>
                            <textarea class="form-control" name="projects[<?= $row['id'] ?>][game_desc]" rows="3"
                                required><?= htmlspecialchars($row['game_desc']) ?></textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Banner (Nova imagem, opcional):</label>
                            <input type="file" class="form-control" name="project_banners[<?= $row['id'] ?>]">
                            <p class="mt-2">Imagem atual: <?= htmlspecialchars($row['game_banner']) ?></p>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Alt do Banner:</label>
                            <input type="text" class="form-control" name="projects[<?= $row['id'] ?>][game_banner_alt]"
                                value="<?= htmlspecialchars($row['game_banner_alt']) ?>" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                </form>
            </div>
        <?php endwhile; ?>
    </div>
</body>

</html>