<?php
require_once __DIR__ . '/connect.php';

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

/**
 * Fetches the logged-in user's company name.
 * 
 * @return string|null Company name if found, null otherwise.
 */
function getCompanyName() {
    global $mysqli;

    // Check if the user is logged in and has a company_id in session
    if (!isset($_SESSION['company_id'])) {
        return null;
    }

    $companyId = (int)$_SESSION['company_id'];

    // Prepared statement to safely fetch the company name
    $stmt = $mysqli->prepare("SELECT company_name FROM companies WHERE id = ?");
    $stmt->bind_param("i", $companyId);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result && $row = $result->fetch_assoc()) {
        return $row['company_name'];
    }

    return null;
}