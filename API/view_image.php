<?php

$imageDirectory = dirname(__FILE__) . '/gambar/';

if(isset($_GET['filename'])) {
    $filename = $_GET['filename'];
    $filePath = $imageDirectory . $filename;

    if (file_exists($filePath)) {
        header('Content-Type: image/jpeg'); 
        readfile($filePath);
        exit;
    } else {
        http_response_code(404);
        echo "File tidak ditemukan.";
        exit;
    }
} else {
    http_response_code(400);
    echo "Parameter 'filename' diperlukan.";
    exit;
}
