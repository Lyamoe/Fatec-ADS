<?php
require_once __DIR__ . '/generalCallings.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !isset($_POST['create-account'])) {
    header("Location: " . BASE_URL . "public/pages/criar-conta-empresa.php");
    exit();
}

//* ========== Capturar e sanitizar as entradas do formulário
$companyName = trim($_POST['company-name'] ?? '');
$username = trim($_POST['username'] ?? '');
$email = filter_var(trim($_POST['email'] ?? ''), FILTER_VALIDATE_EMAIL);
$password = $_POST['password'] ?? '';
$confirmPassword = $_POST['confirm-password'] ?? '';

die("<script>console.log(" . $companyName . $username . $email . $password . $confirmPassword . ");</script>");

//* ========== 2. Validar se algum campo está realmente vazio
if (empty($companyName) || empty($username) || empty($emailRaw) || empty($password) || empty($confirmPassword)) {
    header("Location: " . BASE_URL . "public/pages/criar-conta-empresa.php?fail=emptyfields");
    exit();
}

//* ========== 3. Validar o formato do e-mail separadamente
$email = filter_var($emailRaw, FILTER_VALIDATE_EMAIL);

if (!$email) {
    header("Location: " . BASE_URL . "public/pages/criar-conta-empresa.php?fail=invalidemail");
    exit();
}

if ($password !== $confirmPassword) {
    header("Location: " . BASE_URL . "public/pages/criar-conta-empresa.php?fail=passwordmismatch");
    exit();
}

if (strlen($password) < 8) {
    header("Location: " . BASE_URL . "public/pages/criar-conta-empresa.php?fail=passwordsmall");
    exit();
}

//* ========== Verificar se o e-mail já está cadastrado
$stmtCheck = $mysqli->prepare("SELECT id FROM usuarios WHERE email = ?");
$stmtCheck->bind_param("s", $email);
$stmtCheck->execute();
$stmtCheck->store_result();

if ($stmtCheck->num_rows > 0) {
    $stmtCheck->close();

    header("Location: " . BASE_URL . "public/pages/criar-conta-empresa.php?fail=emailused");
    exit();
}
$stmtCheck->close();

//* ========== Gerar o HASH da senha usando Bcrypt com custo 12
$passwordHash = password_hash($password, PASSWORD_BCRYPT, ['cost' => 12]);

//* ========== Iniciar Transação (Garante que ou cria Empresa + Usuário, ou cancela tudo)
$mysqli->begin_transaction();

try {
    //* ========== Inserir Empresa
    $stmtEmpresa = $mysqli->prepare("INSERT INTO empresas (nome) VALUES (?)");
    $stmtEmpresa->bind_param("s", $companyName);
    $stmtEmpresa->execute();
    
    //* ========== ar o ID gerado para a nova empresa
    $empresaId = $mysqli->insert_id;
    $stmtEmpresa->close();

    //* ========== Inserir Usuário vinculado à Empresa
    $stmtUser = $mysqli->prepare("INSERT INTO usuarios (empresa_id, nome_usuario, email, senha) VALUES (?, ?, ?, ?)");
    $stmtUser->bind_param("isss", $empresaId, $username, $email, $passwordHash);
    $stmtUser->execute();
    $stmtUser->close();

    //* ========== firmar a transação
    $mysqli->commit();

    //* ========== Redirecionar para login ou dashboard com sucesso
    header("Location: ../../public/index.php");
    exit();

} catch (Exception $e) {
    //* ========== erter alterações se der erro em qualquer inserção
    $mysqli->rollback();
    
    //* ========== var log interno do erro e exibir mensagem genérica
    error_log($e->getMessage());
    die("Ocorreu um erro ao cadastrar a conta. Tente novamente mais tarde.");
}