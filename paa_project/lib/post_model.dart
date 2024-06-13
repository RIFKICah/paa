import 'dart:convert';
import 'package:http/http.dart' as http;

class PostMod {
  final int id;
  final String namaMakanan;
  final String? deskripsi; // Allow deskripsi to be nullable
  final String cuaca;
  final String linkGambar;

  PostMod({
    required this.id,
    required this.namaMakanan,
    required this.deskripsi,
    required this.cuaca,
    required this.linkGambar,
  });

  factory PostMod.fromJson(Map<String, dynamic> json) {
    return PostMod(
      id: json['id'],
      namaMakanan: json['nama_makanan'],
      deskripsi: json['deskripsi'] ??
          '', // Provide a default value if deskripsi is null
      cuaca: json['cuaca'],
      linkGambar: json['link_gambar'],
    );
  }

  static Future<List<PostMod>> connectToAPI() async {
    final response = await http.get(Uri.parse('http://localhost:8000/api.php'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        // Check if the response is JSON
        if (response.headers['content-type']?.contains('application/json') ==
            true) {
          Map<String, dynamic> jsonResponse = json.decode(response.body);
          List<dynamic> dataList = jsonResponse['data'];
          return dataList.map((data) => PostMod.fromJson(data)).toList();
        } else {
          throw Exception('Received non-JSON response');
        }
      } catch (e) {
        throw Exception('Failed to parse JSON: $e');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
