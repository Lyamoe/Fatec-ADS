<?php
require_once __DIR__ . '/../../private/config/generalCallings.php';

if (!isset($_SESSION['user_id']) || !isset($_SESSION['user_name'])) {
    header("Location: login.php");
    exit();
} else {
    //* ========== Set page metadata
    $pageTitle = "Consultar estoque | GeloGest";
    $metaDescription = "Acompanhe o estoque da sua empresa de forma prática e eficiente com o GeloGest.";

    $statusTranslations = [
        'in_stock' => 'Estoque',
        'display' => 'Vitrine',
        'finished' => 'Finalizado',
        'discarded' => 'Descartado'
    ];
    ?>

    <!DOCTYPE html>
    <html lang="pt-BR">

    <head>

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <!-- //*  Core SEO Meta Tags -->
        <title><?= $pageTitle ?></title>
        <meta name="description" content="<?= $metaDescription ?>" />
        <meta name="robots" content="index, follow" />
        <link rel="canonical" href="https://gelogest.infinityfreeapp.com" />

        <!-- //*  Open Graph (Facebook / WhatsApp / LinkedIn preview) -->
        <meta property="og:type" content="website" />
        <meta property="og:title" content="<?= $pageTitle ?>" />
        <meta property="og:description" content="<?= $metaDescription ?>" />
        <meta property="og:image" content="https://gelogest.infinityfreeapp.com/img/og-preview.png" />
        <!-- //* ========== todo: update to actual picture -->

        <!-- //*  Assets -->
        <link rel="icon" type="image/png" sizes="32x32" href="img/siteIcon.png" />
        <!-- //* ========== todo: update to actual picture -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+Condensed:ital,wght@0,100;0,400;0,700;1,400&family=Lilita+One&display=swap"
            rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="<?php echo BASE_URL; ?>public/styles/css/stock-search.css" />
    </head>

    <body class="body">
        <?php require_once BASE_PATH . 'public/pages/includes/header.php'; ?>

        <main class="main">
            <div class="stock-header">
                <h2 class="stock-header__title">Estoque Atual</h2>
            </div>

            <?php

            // Obtém e sanitiza o ID da empresa logada na sessão
            $companyId = isset($_SESSION['company_id']) ? intval($_SESSION['company_id']) : 0;

            // Consulta SQL filtrando pela empresa atual e apenas pelos status 'in_stock' ou 'display'
            $query = "SELECT si.*, f.flavor_name, c.container_name, c.container_code, 
                         MAX(dsl.created_at) AS last_updated
                  FROM stock_items si
                  JOIN flavors f ON si.flavor_id = f.id
                  JOIN containers c ON si.container_id = c.id
                  LEFT JOIN daily_stock_logs dsl ON si.id = dsl.stock_item_id
                  WHERE si.company_id = $companyId 
                    AND si.status IN ('in_stock', 'display')
                  GROUP BY si.id, f.flavor_name, c.container_name, c.container_code, 
                           si.company_id, si.flavor_id, si.container_id, si.arrival_date, 
                           si.best_before_date, si.status, si.current_gross_weight_grams, 
                           si.current_net_weight_grams
                  ORDER BY flavor_name ASC";

            $result = mysqli_query($conn, $query);

            if ($result && mysqli_num_rows($result) > 0) {
                echo '<div class="stock-table-wrapper">';
                echo '<table class="stock-table">';
                echo '<thead class="stock-table__head">';
                echo '<tr class="stock-table__row stock-table__row--header">';
                echo '<th class="stock-table__cell stock-table__cell--header">Sabor</th>';
                echo '<th class="stock-table__cell stock-table__cell--header">Recipiente</th>';
                echo '<th class="stock-table__cell stock-table__cell--header">Status</th>';
                echo '<th class="stock-table__cell stock-table__cell--header">Peso Bruto (g)</th>';
                echo '<th class="stock-table__cell stock-table__cell--header">Peso Líquido (g)</th>';
                echo '<th class="stock-table__cell stock-table__cell--header">Última Atualização</th>';
                echo '</tr>';
                echo '</thead>';
                echo '<tbody class="stock-table__body">';

                while ($row = mysqli_fetch_assoc($result)) {
                    $flavor = htmlspecialchars($row['flavor_name']);
                    $container = htmlspecialchars($row['container_name'] . ' (' . $row['container_code'] . ')');

                    // Traduz o status atual do item na tabela stock_items
                    $rawStatus = $row['status'];
                    $translatedStatus = $statusTranslations[$rawStatus] ?? $rawStatus;
                    $status = htmlspecialchars($translatedStatus);

                    $gross = htmlspecialchars($row['current_gross_weight_grams']);
                    $net = htmlspecialchars($row['current_net_weight_grams']);
                    $lastUpdated = $row['last_updated'] ? htmlspecialchars($row['last_updated']) : 'N/A';

                    echo '<tr class="stock-table__row">';
                    echo "<td class=\"stock-table__cell\">{$flavor}</td>";
                    echo "<td class=\"stock-table__cell\">{$container}</td>";
                    echo "<td class=\"stock-table__cell\">{$status}</td>";
                    echo "<td class=\"stock-table__cell\">{$gross}</td>";
                    echo "<td class=\"stock-table__cell\">{$net}</td>";
                    echo "<td class=\"stock-table__cell\">{$lastUpdated}</td>";
                    echo '</tr>';
                }

                echo '</tbody>';
                echo '</table>';
                echo '</div>';
            } else {
                echo '<p class="stock-message">Nenhum item em estoque ou exibição cadastrado para esta empresa.</p>';
            }
            ?>
        </main>

        <?php require_once BASE_PATH . 'public/pages/includes/footer.php'; ?>
    </body>

    </html>
    <?php
}
?>