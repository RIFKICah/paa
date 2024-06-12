<?php
require 'config.php';

header('Content-Type: application/json');

header("Access-Control-Allow-Origin: *");

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $stmt = $pdo->query('SELECT * FROM makanan');
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($result) {
        $response = ['status' => 'success', 'data' => $result];
        echo json_encode($response);
    } else {
        $response = ['status' => 'error', 'message' => 'No data found'];
        echo json_encode($response);
    }
} else {
    $response = ['status' => 'error', 'message' => 'Invalid request method'];
    echo json_encode($response);
}
?>


