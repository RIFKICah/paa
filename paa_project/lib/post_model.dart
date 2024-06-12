  import 'dart:convert';
  import 'package:http/http.dart' as http;

  class PostMod {
    String namaMakanan;
    String deskripsi;
    String cuaca;
    String linkGambar; 

    PostMod({
      this.namaMakanan = '',
      this.deskripsi = '',
      this.cuaca = '',
      this.linkGambar = '', 
    });

    factory PostMod.createPostMod(Map<String, dynamic> object) {
      return PostMod(
        namaMakanan: object['nama_makanan'] ?? '',
        deskripsi: object['deskripsi'] ?? '',
        cuaca: object['cuaca'] ?? '',
        linkGambar: object['link_gambar'] ?? '',  
      );
    }

    static Future<PostMod> connectToAPI() async {
      try {
        Uri apiURL = Uri.parse("http://localhost:8000/api.php");
        var apiResult = await http.get(apiURL);

        if (apiResult.statusCode == 200) {
          var jsonObject = json.decode(apiResult.body);

          if (jsonObject['status'] == 'success' &&
              jsonObject['data'] != null &&
              jsonObject['data'].isNotEmpty) {
            return PostMod.createPostMod(jsonObject['data'][0]);
          }
        }
        throw Exception('Failed to fetch data from API');
      } catch (e) {
        throw Exception('Failed to connect to API: $e');
      }
    }

    
    static Future<http.Response> fetchImage(String imageUrl) async {
      return await http.get(Uri.parse(imageUrl));
    }
  }
