import 'dart:convert';
import 'package:http/http.dart' as http;

class PostMod {
  String namaMakanan;
  String deskripsi;
  String cuaca;
  String jamBuka;
  String jamTutup;
  String linkMap;
  String linkProduk;

  PostMod({
    this.namaMakanan = '',
    this.deskripsi = '', 
    this.cuaca = '',
    this.jamBuka = '',
    this.jamTutup = '',
    this.linkMap = '',
    this.linkProduk = '',
  });

  factory PostMod.createPostMod(Map<String, dynamic> object) {
    return PostMod(
      namaMakanan: object['nama_makanan'],
      deskripsi: object['deskripsi'],
      cuaca: object['cuaca'],
      jamBuka: object['jam_buka'],
      jamTutup: object['jam_tutup'],
      linkMap: object['link_map'],
      linkProduk: object['link_produk'],
    );
  }

  static Future<PostMod> connectToAPI(
    String namaMakanan,
    String deskripsi,
    String cuaca,
    String jamBuka,
    String jamTutup,
    String linkMap,
    String linkProduk,
  ) async {
    Uri apiURL = Uri.parse("http://localhost:8000/api.php");

    var apiResult = await http.post(apiURL, body: {
      "nama_makanan": namaMakanan,
      "deskripsi": deskripsi,
      "cuaca": cuaca,
      "jam_buka": jamBuka,
      "jam_tutup": jamTutup,
      "link_map": linkMap,
      "link_produk": linkProduk,
    });

    var jsonObject = json.decode(apiResult.body);

    return PostMod.createPostMod(jsonObject);
  }
}
