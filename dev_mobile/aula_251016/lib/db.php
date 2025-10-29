<?php
    header('Content-Type: application/json');

    $servername = "sql304.infinityfree.com";
    $username = "if0_40187129";
    $password = "milane1213infin";
    $dbname = "if0_40187129_XXX"; // nome tá errado

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
    }

    $sql = "SELECT id, name,FROM usuarios";
    $result = $conn->query($sql);

    $data = array();
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
    }

    $conn->close();
    echo json_encode($data);
?>