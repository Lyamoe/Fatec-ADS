<?php
require_once __DIR__ . '/../../private/config/generalCallings.php';

// Authentication & Session Guard
if (!isset($_SESSION['user_id']) || !isset($_SESSION['company_id'])) {
    header("Location: login.php");
    exit();
}

$companyId = (int) $_SESSION['company_id'];
$userId = (int) $_SESSION['user_id'];
$message = '';
$messageType = '';

// Handle Form Submission
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_stock'])) {
    $items = $_POST['items'] ?? [];

    if (!empty($items) && is_array($items)) {
        $conn->begin_transaction();

        try {
            $today = date('Y-m-d');

            foreach ($items as $itemId => $itemData) {
                $itemId = (int) $itemId;
                $newStatus = $itemData['status'] ?? '';
                $newGrossWeight = isset($itemData['gross_weight']) ? (int) $itemData['gross_weight'] : 0;

                // Validate allowed status values matching DB enum schema
                if (!in_array($newStatus, ['in_stock', 'display', 'finished', 'discarded'], true)) {
                    continue;
                }

                // Fetch item current state and tare weight
                $queryFetch = "SELECT s.status, s.current_gross_weight_grams, c.tare_weight_grams 
                                FROM stock_items s 
                                INNER JOIN containers c ON s.container_id = c.id 
                                WHERE s.id = ? AND s.company_id = ?";
                $stmtFetch = $conn->prepare($queryFetch);
                $stmtFetch->bind_param("ii", $itemId, $companyId);
                $stmtFetch->execute();
                $resultFetch = $stmtFetch->get_result();

                if ($row = $resultFetch->fetch_assoc()) {
                    $prevStatus = $row['status'];
                    $tareWeight = (int) $row['tare_weight_grams'];

                    // Calculate net weight (clamp at 0 if negative)
                    $newNetWeight = max(0, $newGrossWeight - $tareWeight);

                    // 1. Insert entry into daily_stock_logs
                    $queryLog = "INSERT INTO daily_stock_logs (stock_item_id, user_id, log_date, previous_status, new_status, gross_weight_grams, net_weight_grams) 
                                VALUES (?, ?, ?, ?, ?, ?, ?)";
                    $stmtLog = $conn->prepare($queryLog);
                    $stmtLog->bind_param("iisssii", $itemId, $userId, $today, $prevStatus, $newStatus, $newGrossWeight, $newNetWeight);
                    $stmtLog->execute();
                    $stmtLog->close();

                    // Update stock_items if remaining in_stock or display
                    $queryUpdate = "UPDATE stock_items 
                                        SET status = ?, current_gross_weight_grams = ?, current_net_weight_grams = ? 
                                        WHERE id = ? AND company_id = ?";
                    $stmtUpdate = $conn->prepare($queryUpdate);
                    $stmtUpdate->bind_param("siiii", $newStatus, $newGrossWeight, $newNetWeight, $itemId, $companyId);
                    $stmtUpdate->execute();
                    $stmtUpdate->close();
                }
                $stmtFetch->close();
            }

            $conn->commit();
            $message = "Estoque atualizado com sucesso!";
            $messageType = "success";
        } catch (Exception $e) {
            $conn->rollback();
            $message = "Erro ao atualizar estoque. Tente novamente.";
            $messageType = "error";
        }
    }
}

// Fetch active stock items for company joined with flavor names
$queryStock = "SELECT s.id, s.status, s.current_gross_weight_grams, s.arrival_date, f.flavor_name, c.container_name 
                FROM stock_items s 
                INNER JOIN flavors f ON s.flavor_id = f.id 
                INNER JOIN containers c ON s.container_id = c.id 
                WHERE s.company_id = ? AND s.status IN ('in_stock', 'display')
                ORDER BY f.flavor_name ASC, s.arrival_date ASC";

$stmtStock = $conn->prepare($queryStock);
$stmtStock->bind_param("i", $companyId);
$stmtStock->execute();
$stockItems = $stmtStock->get_result()->fetch_all(MYSQLI_ASSOC);
$stmtStock->close();

// Set metadata
$pageTitle = "Atualização diária de estoque | GeloGest";
$metaDescription = "Altere o estoque diário de produtos, incluindo sabores, recipientes, status e pesos. Mantenha seu inventário atualizado com facilidade.";
?>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title><?= htmlspecialchars($pageTitle, ENT_QUOTES, 'UTF-8') ?></title>
    <meta name="description" content="<?= htmlspecialchars($metaDescription, ENT_QUOTES, 'UTF-8') ?>" />
    <meta name="robots" content="index, follow" />
    <link rel="canonical" href="https://gelogest.infinityfreeapp.com" />

    <meta property="og:type" content="website" />
    <meta property="og:title" content="<?= htmlspecialchars($pageTitle, ENT_QUOTES, 'UTF-8') ?>" />
    <meta property="og:description" content="<?= htmlspecialchars($metaDescription, ENT_QUOTES, 'UTF-8') ?>" />
    <meta property="og:image" content="https://gelogest.infinityfreeapp.com/img/og-preview.png" />

    <link rel="icon" type="image/png" sizes="32x32" href="img/siteIcon.png" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+Condensed:ital,wght@0,100;0,400;0,700;1,400&family=Lilita+One&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="<?php echo BASE_URL; ?>public/styles/css/stock-update.css" />
</head>

<body class="page-body">
    <?php require_once BASE_PATH . 'public/pages/includes/header.php'; ?>

    <main class="main stock-update">
        <header class="stock-update__header">
            <h2 class="stock-update__title">Atualização Diária do Estoque</h2>
        </header>

        <?php if (!empty($message)): ?>
            <div class="alert alert--<?= htmlspecialchars($messageType, ENT_QUOTES, 'UTF-8') ?>" role="alert">
                <?= htmlspecialchars($message, ENT_QUOTES, 'UTF-8') ?>
            </div>
        <?php endif; ?>

        <?php if (empty($stockItems)): ?>
            <p class="stock-update__empty-message">Nenhum item encontrado no estoque.</p>
        <?php else: ?>
            <form method="POST" action="" class="stock-update__form">
                <div class="stock-grid">
                    <?php foreach ($stockItems as $item): ?>
                        <article class="stock-card">
                            <h3 class="stock-card__flavor">
                                <?= htmlspecialchars($item['flavor_name'], ENT_QUOTES, 'UTF-8') ?>
                            </h3>

                            <p class="stock-card__detail">
                                Recipiente:
                                <span
                                    class="stock-card__value"><?= htmlspecialchars($item['container_name'], ENT_QUOTES, 'UTF-8') ?></span>
                            </p>

                            <p class="stock-card__detail">
                                Peso Bruto Atual:
                                <strong class="stock-card__value"><?= (int) $item['current_gross_weight_grams'] ?>g</strong>
                            </p>

                            <div class="stock-card__field">
                                <label for="status_<?= $item['id'] ?>" class="stock-card__label">Status:</label>
                                <select name="items[<?= $item['id'] ?>][status]" id="status_<?= $item['id'] ?>"
                                    class="stock-card__select">
                                    <option value="in_stock" <?= $item['status'] === 'in_stock' ? 'selected' : '' ?>>Em Estoque
                                        (in_stock)</option>
                                    <option value="display" <?= $item['status'] === 'display' ? 'selected' : '' ?>>Na Cuba/Vitrine
                                        (display)</option>
                                    <option value="finished" <?= $item['status'] === 'finished' ? 'selected' : '' ?>>Finalizado
                                        (finished)</option>
                                    <option value="discarded" <?= $item['status'] === 'discarded' ? 'selected' : '' ?>>Descartado
                                        (discarded)</option>
                                </select>
                            </div>

                            <div class="stock-card__field">
                                <label for="weight_<?= $item['id'] ?>" class="stock-card__label">Novo Peso Bruto (g):</label>
                                <input type="number" name="items[<?= $item['id'] ?>][gross_weight]"
                                    id="weight_<?= $item['id'] ?>" class="stock-card__input"
                                    value="<?= (int) $item['current_gross_weight_grams'] ?>" min="0" required />
                            </div>
                        </article>
                    <?php endforeach; ?>
                </div>

                <div class="stock-update__actions">
                    <button type="submit" name="update_stock" class="stock-update__button">Salvar Atualizações</button>
                </div>
            </form>
        <?php endif; ?>
    </main>

    <?php require_once BASE_PATH . 'public/pages/includes/footer.php'; ?>
</body>

</html>