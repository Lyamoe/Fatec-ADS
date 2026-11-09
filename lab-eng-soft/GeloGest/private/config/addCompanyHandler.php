<?php
require_once __DIR__ . '/generalCallings.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !isset($_POST['create-account'])) {
    header("Location: " . BASE_URL . "public/pages/criar-conta-empresa.php");
    exit();
}

//* ========== Capturar e sanitizar as entradas do formulário
$companyName = trim($_POST['company-name'] ?? '');
$username = trim($_POST['username'] ?? '');
$emailRaw = trim($_POST['email'] ?? '');
$password = $_POST['password'] ?? '';
$confirmPassword = $_POST['confirm-password'] ?? '';

//* ========== Validação de campos
if (empty($companyName) || empty($username) || empty($emailRaw) || empty($password) || empty($confirmPassword)) {
    header("Location: " . BASE_URL . "public/pages/criar-conta-empresa.php?fail=emptyfields");
    exit();
}

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

//* ========== Gerar o HASH da senha usando Bcrypt com custo 12
$passwordHash = password_hash($password, PASSWORD_BCRYPT, ['cost' => 12]);

//* ========== Iniciar Transação (Garante que ou cria Empresa + Usuário, ou cancela tudo)
$conn->begin_transaction();

//* ========== Verificar se o e-mail já está cadastrado
$stmtCheck = $conn->prepare("SELECT id FROM users_login WHERE user_email = ?");
$stmtCheck->bind_param("s", $email);
$stmtCheck->execute();
$stmtCheck->store_result();

if ($stmtCheck->num_rows > 0) {
    $stmtCheck->close();

    header("Location: " . BASE_URL . "public/pages/criar-conta-empresa.php?fail=emailused");
    exit();
}
$stmtCheck->close();

try {
    //* ========== Inserir Empresa
    $stmtEmpresa = $conn->prepare("INSERT INTO companies (company_name) VALUES (?)");
    $stmtEmpresa->bind_param("s", $companyName);
    $stmtEmpresa->execute();
    
    //* ========== Pegar o ID gerado para a nova empresa
    $empresaId = $conn->insert_id;
    $stmtEmpresa->close();

    $accountType = 'admin';

    //* ========== Inserir Usuário vinculado à Empresa
    $stmtUser = $conn->prepare("INSERT INTO users_login (company_id, user_name, user_password, user_email, user_type) VALUES (?, ?, ?, ?, ?)");
    $stmtUser->bind_param("issss", $empresaId, $username, $passwordHash, $email, $accountType);
    $stmtUser->execute();
    $stmtUser->close();

    //* ========== firmar a transação
    $conn->commit();

    //* ========== Redirecionar para login ou dashboard com sucesso
    header("Location: " . BASE_URL . "public/index.php");
    exit();

} catch (Exception $e) {
    //* ========== erter alterações se der erro em qualquer inserção
    $mysqli->rollback();
    
    //* ========== var log interno do erro e exibir mensagem genérica
    error_log($e->getMessage());
    die("Ocorreu um erro ao cadastrar a conta. Tente novamente mais tarde.");
}