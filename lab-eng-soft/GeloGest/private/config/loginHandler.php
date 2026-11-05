<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once 'connect.php';

if (!isset($_SESSION['login_attempts'])) {
    $_SESSION['login_attempts'] = 0;
}
if (!isset($_SESSION['last_attempt_time'])) {
    $_SESSION['last_attempt_time'] = 0;
}
$lockout_time = 900;
$current_time = time();

//? Verifica se o usuário excedeu o número de tentativas de login
if ($_SESSION['login_attempts'] >= 5 && ($current_time - $_SESSION['last_attempt_time']) < $lockout_time) {
    $remaining = $lockout_time - ($current_time - $_SESSION['last_attempt_time']);
    $minutes = floor($remaining / 60);
    $seconds = $remaining % 60;
    echo "<script>window.alert('Você excedeu o número de tentativas. Tente novamente em {$minutes} minutos e {$seconds} segundos.');</script>";

} else {
    //? Reseta o contador de tentativas se o tempo de bloqueio já tiver passado
    if (($current_time - $_SESSION['last_attempt_time']) >= $lockout_time) {
        $_SESSION['login_attempts'] = 0;
        $_SESSION['last_attempt_time'] = 0;
    }

    //? Código de login
    if (isset($_POST['login-submit'])) {
        $user = trim($_POST['username'] ?? '');
        $pass = $_POST['password'] ?? '';

        if ($user === '' || $pass === '') {
            showLoginError($current_time, "emptyfields");
        } else {
            $stmt = $mysqli->prepare("SELECT * FROM user_login WHERE user_name = ?");
            $stmt->bind_param("s", $user);
            $stmt->execute();
            $getData = $stmt->get_result();

            if ($getData && $getData->num_rows === 1) {
                $mostra = $getData->fetch_object();
                if (password_verify($pass, $mostra->user_password)) {
                    $_SESSION['user_id'] = $mostra->id;
                    $_SESSION['user_name'] = $mostra->user_name;
                    $_SESSION['user_type'] = $mostra->user_type;
                    $_SESSION['company_id'] = $mostra->company_id;
                    $_SESSION['login_attempts'] = 0;
                    $_SESSION['last_attempt_time'] = 0;
                    echo "<script>console.log('Login realizado com sucesso!');</script>";
                    header("Location:../../public/index.php");
                    exit();
                } else {
                    showLoginError($current_time, "incorrectlogin");
                }
            } else {
                showLoginError($current_time, "incorrectlogin");
            }
        }
    }
}

function showLoginError($current_time, $errorType){
    $_SESSION['login_attempts']++;
    $_SESSION['last_attempt_time'] = $current_time;
    header("Location:../../public/pages/login.php?fail={$errorType}");
    exit();
}