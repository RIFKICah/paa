import 'package:flutter/material.dart';
import 'package:paa_project/post_model.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PostMod? postMod;
  String cuaca = "Cerah";
  String deskripsi = "Cuaca cerah dengan sedikit awan.";
  String jamBuka = "08:00";
  String jamTutup = "20:00";
  String linkMap = "http://maps.example.com";
  String linkProduk = "http://produk.example.com";
  String namaMakanan = "Nasi Goreng";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    postMod = await PostMod.connectToAPI(
      cuaca,
      deskripsi,
      jamBuka,
      jamTutup,
      linkMap,
      linkProduk,
      namaMakanan,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("API"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              if (postMod != null)
                Text(
                  "cuaca: ${postMod!.cuaca}\n"
                  "deskripsi: ${postMod!.deskripsi}\n"
                  "jam_buka: ${postMod!.jamBuka}\n"
                  "jam_tutup: ${postMod!.jamTutup}\n"
                  "link_map: ${postMod!.linkMap}\n"
                  "link_produk: ${postMod!.linkProduk}\n"
                  "nama_makanan: ${postMod!.namaMakanan}",
                )
              else
                Text("tidak ada"),
              ElevatedButton(
                onPressed: fetchData,
                child: Text("POST"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
