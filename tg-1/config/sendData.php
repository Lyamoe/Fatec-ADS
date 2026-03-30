<?php
require_once __DIR__ . '/../config/connect.php';
require_once __DIR__ . '/../config/sqlFields.php';

// ? Functions under there
function insertProject($data) {
    global $mysqli;
    $sql = "INSERT INTO projects (titulo_atividade, materia_atividade, data_atribuicao, data_entrega) VALUES (?, ?, ?, ?)";

    $stmt = $mysqli->prepare($sql);
    if (!$stmt) {
        error_log("Erro ao preparar SQL: {$mysqli->error}");
        header('location:../public/admin/index.php?fail=8');
        exit;
    }

    $stmt->bind_param(
        "ssss", 
        $data['titulo_atividade'], 
        $data['materia_atividade'], 
        $data['data_atribuicao'], 
        $data['data_entrega']
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

    $gameBanner = uploadFile($_FILES['project-banner'], 'projects', 'data_atribuicao', null, true);

    $data = [
        'titulo_atividade' => $gameName,
        'materia_atividade' => $gameDesc,
        'data_atribuicao' => $gameBanner,
        'data_entrega' => $gameBannerAlt
    ];

    insertProject($data);

    header('location:../public/admin/index.php?success=1');
    exit;
}