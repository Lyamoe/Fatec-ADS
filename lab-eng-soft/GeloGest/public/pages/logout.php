<?php
session_start();
unset($_SESSION['user_id']);
unset($_SESSION['user_name']);
unset($_SESSION['login_attempts']);
unset($_SESSION['last_attempt_time']);
header("Location:login.php");