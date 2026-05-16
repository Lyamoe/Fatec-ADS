<?php
require_once 'connect.php';
require_once 'sqlFields.php';

function getDbInfo($fieldIndex, $tableIndex)
{
    global $mysqli, $sqlTables, $sqlFields;
    $table = $sqlTables[$tableIndex];
    $field = $sqlFields[$fieldIndex];

    $sql = "SELECT `$field` FROM $table WHERE id = '1'";
    $result = mysqli_query($mysqli, $sql);

    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        return $row[$field];
    } else {
        return "";
    }
}