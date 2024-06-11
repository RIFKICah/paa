<?php
// api.php
require 'config.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);

    // Validasi input
    if (isset($input['cuaca']) && isset($input['deskripsi']) && isset($input['jam_buka']) && isset($input['jam_tutup']) && isset($input['link_map']) && isset($input['link_produk']) && isset($input['nama_makanan'])) {
        $cuaca = $input['cuaca'];
        $deskripsi = $input['deskripsi'];
        $jam_buka = $input['jam_buka'];
        $jam_tutup = $input['jam_tutup'];
        $link_map = $input['link_map'];
        $link_produk = $input['link_produk'];
        $nama_makanan = $input['nama_makanan'];

        // Insert data ke database
        $stmt = $pdo->prepare('INSERT INTO makanan (cuaca, deskripsi, jam_buka, jam_tutup, link_map, link_produk, nama_makanan) VALUES (:cuaca, :deskripsi, :jam_buka, :jam_tutup, :link_map, :link_produk, :nama_makanan)');
        $result = $stmt->execute(['cuaca' => $cuaca, 'deskripsi' => $deskripsi, 'jam_buka' => $jam_buka, 'jam_tutup' => $jam_tutup, 'link_map' => $link_map, 'link_produk' => $link_produk, 'nama_makanan' => $nama_makanan]);

        if ($result) {
            $response = ['status' => 'success', 'message' => 'Data inserted successfully'];
            echo json_encode($response);
        } else {
            $response = ['status' => 'error', 'message' => 'Failed to insert data'];
            echo json_encode($response);
        }
    } else {
        $response = ['status' => 'error', 'message' => 'Invalid input'];
        echo json_encode($response);
    }
} else {
    $response = ['status' => 'error', 'message' => 'Invalid request method'];
    echo json_encode($response);
}
?>
