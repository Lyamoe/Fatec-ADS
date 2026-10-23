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
            echo "<script>window.alert('Preencha todos os campos!');</script>";
        } else {
            $stmt = $mysqli->prepare("SELECT * FROM employee_login WHERE admin_name = ?");
            $stmt->bind_param("s", $user);
            $stmt->execute();
            $getData = $stmt->get_result();

            if ($getData && $getData->num_rows === 1) {
                $mostra = $getData->fetch_object();
                if (password_verify($pass, $mostra->admin_password)) {
                    $_SESSION['user_id'] = $mostra->id;
                    $_SESSION['user_name'] = $mostra->admin_name;
                    $_SESSION['login_attempts'] = 0;
                    $_SESSION['last_attempt_time'] = 0;
                    echo "<script>console.log SOCORRO</script>";
                    header("Location:../public/admin/index.php");
                    exit();
                } else {
                    wrongLogin($current_time);
                }
            } else {
                wrongLogin($current_time);
            }
        }
    }
}

function wrongLogin($current_time){
    $_SESSION['login_attempts']++;
    $_SESSION['last_attempt_time'] = $current_time;
    header('location:../public/admin/login.php?fail=10');
    exit();
}