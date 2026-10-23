<?php
require_once __DIR__ . '/../private/config/connect.php';
require_once __DIR__ . '/../private/config/sqlFields.php';

// ? Functions under there
function insertProject($data) {
    global $mysqli;
    $sql = "INSERT INTO projects (game_name, game_desc, game_banner, game_banner_alt) VALUES (?, ?, ?, ?)";

    $stmt = $mysqli->prepare($sql);
    if (!$stmt) {
        error_log("Erro ao preparar SQL: {$mysqli->error}");
        header('location:../public/admin/index.php?fail=8');
        exit;
    }

    $stmt->bind_param(
        "ssss", 
        $data['game_name'], 
        $data['game_desc'], 
        $data['game_banner'], 
        $data['game_banner_alt']
    );

    if (!$stmt->execute()) {
        error_log("Erro ao executar SQL: {$stmt->error}");
        header('location:../public/admin/index.php?fail=9');
        exit;
    }

    $stmt->close();
}

function processFormInput($table, $inputId, $sqlField = null, $path = null)
{
    global $mysqli, $sqlTables;
    validateTable($table, $sqlTables);
    if ($sqlField === null) {
        $sqlField = $inputId;
    }
    $value = getValueFromInput($inputId, $path);
    executeDbQuery($mysqli, $table, $sqlField, $value, $sqlTables);
}

function validateTable($table, $sqlTables)
{
    if (!in_array($table, $sqlTables)) {
        error_log("Tentativa de acesso a tabela inválida: {$table}");
        header('location:../public/admin/index.php?fail=6');
        exit;
    }
}

function getValueFromInput($inputId, $path)
{
    if ($path === null) {
        $value = trim($_POST[$inputId]);
        if (strlen($value) < 4) {
            header('location:../public/admin/index.php?fail=7');
            exit;
        }
        return $value;
    } else {
        return $path;
    }
}

function executeDbQuery($mysqli, $table, $sqlField, $value, $sqlTables)
{
    $sql = $table !== $sqlTables[2]
        ? "UPDATE {$table} SET {$sqlField} = ? WHERE id = 1"
        : "INSERT INTO {$table} ({$sqlField}) VALUES (?)";

    $stmt = $mysqli->prepare($sql);
    if (!$stmt) {
        error_log("Erro ao preparar SQL: {$mysqli->error}");
        header('location:../public/admin/index.php?fail=8');
        exit;
    }

    $stmt->bind_param("s", $value);
    if (!$stmt->execute()) {
        error_log("Erro ao executar SQL: {$stmt->error}");
        header('location:../public/admin/index.php?fail=9');
        exit;
    }

    $stmt->close();
}

function uploadFile($file, $table, $sqlField, $unique = null, $multiCols = false)
{
    $uploadDir = getUploadDir();

    validateUploadDir($uploadDir);
    validateFileError($file);
    validateFileSize($file, 10 * 1024 * 1024);
    validateMimeType($file, ['image/jpeg', 'image/png', 'image/gif']);

    $targetPath = generateTargetPath($file, $uploadDir, $unique);

    moveUploadedFile($file['tmp_name'], $targetPath);

    $relativePath = "../uploads/" . basename($targetPath);
    if ($multiCols) {
        return $relativePath;
    } else {
        processFormInput($table, null, $sqlField, $relativePath);
    }

}

function getUploadDir()
{
    return realpath(__DIR__ . '/../') . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR;
}

function validateUploadDir($uploadDir)
{
    if (!is_dir($uploadDir)) {
        if (!mkdir($uploadDir, 0777, true)) {
            error_log("Falha ao criar diretório de upload: $uploadDir");
            header('location:../public/admin/index.php?fail=1');
            exit;
        }
    }
}

function validateFileError($file)
{
    if ($file['error'] !== UPLOAD_ERR_OK) {
        error_log("Erro no upload: código de erro " . $file['error']);
        header('location:../public/admin/index.php?fail=2');
        exit;
    }
}

function validateFileSize($file, $maxFileSize)
{
    if ($file['size'] > $maxFileSize) {
        header('location:../public/admin/index.php?fail=3');
        exit;
    }
}

function validateMimeType($file, $allowedTypes)
{
    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mimeType = finfo_file($finfo, $file['tmp_name']);
    finfo_close($finfo);
    if (!in_array($mimeType, $allowedTypes)) {
        header('location:../public/admin/index.php?fail=4');
        exit;
    }
}

function generateTargetPath($file, $uploadDir, $unique)
{
    $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));

    if ($unique) {
        foreach (glob("{$uploadDir}{$unique}.*") as $oldFile) {
            unlink($oldFile);
        }
        return "{$uploadDir}{$unique}.{$ext}";
    } else {
        $safeName = preg_replace('/[^a-zA-Z0-9._-]/', '', basename($file['name']));
        return "{$uploadDir}" . time() . "_{$safeName}";
    }
}

function moveUploadedFile($tmpPath, $targetPath)
{
    if (!move_uploaded_file($tmpPath, $targetPath)) {
        error_log("Falha ao mover o arquivo para: $targetPath");
        header('location:../public/admin/index.php?fail=5');
        exit;
    }
}


//* ==================== Post set ====================
if (isset($_POST['title-submit'])) {
    processFormInput($sqlTables[0], $sqlFields[0]);
    header('location:../public/admin/index.php?success=1');
    exit;
}
if (isset($_POST['subtitle-submit'])) {
    processFormInput($sqlTables[0], $sqlFields[1]);
    header('location:../public/admin/index.php?success=1');
    exit;
}
if (isset($_POST['self-desc-submit'])) {
    processFormInput($sqlTables[1], 'self-desc', $sqlFields[2]);
    header('location:../public/admin/index.php?success=1');
    exit;
}
if (isset($_POST['pfp-submit'])) {
    uploadFile($_FILES['profile-picture'], $sqlTables[1], $sqlFields[3], "pfp");
    processFormInput($sqlTables[1], 'pfp-alt', $sqlFields[4]);
    header('location:../public/admin/index.php?success=1');
    exit;
}
if (isset($_POST['profile-banner-submit'])) {
    uploadFile($_FILES['profile-banner'], $sqlTables[1], $sqlFields[5], "banner");
    processFormInput($sqlTables[1], 'banner-alt', $sqlFields[6]);
    header('location:../public/admin/index.php?success=1');
    exit;
}
if (isset($_POST['projects-submit'])) {
    $gameName = trim($_POST['project-name']);
    $gameDesc = trim($_POST['project-description']);
    $gameBannerAlt = trim($_POST['project-banner-alt']);

    if (strlen($gameName) < 4 || strlen($gameDesc) < 4) {
        header('location:../public/admin/index.php?fail=7');
        exit;
    }

    $gameBanner = uploadFile($_FILES['project-banner'], $sqlTables[2], $sqlFields[9], null, true);

    $data = [
        'game_name' => $gameName,
        'game_desc' => $gameDesc,
        'game_banner' => $gameBanner,
        'game_banner_alt' => $gameBannerAlt
    ];

    insertProject($data);

    header('location:../public/admin/index.php?success=1');
    exit;
}