  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';

  import 'post_model.dart'; 

  class Barang {
    final String nama;
    final String image;
    final String deskripsi;

    Barang({
      required this.nama,
      required this.image,
      required this.deskripsi,
    });

    factory Barang.fromPostMod(PostMod postMod) {
      return Barang(
        nama: postMod.namaMakanan,
        image: postMod.linkGambar,
        deskripsi: postMod.deskripsi,
      );
    }
  }

  class Nyobagridvies extends StatefulWidget {
    @override
    _NyobagridviesState createState() => _NyobagridviesState();
  }

  class _NyobagridviesState extends State<Nyobagridvies> {
    late Future<PostMod> futureBarangList;

    @override
    void initState() {
      super.initState();
      futureBarangList = PostMod.connectToAPI();
    }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          body: FutureBuilder<PostMod>(
            future: futureBarangList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                var barang = Barang.fromPostMod(snapshot.data!);
                return buildCard(context, barang);
              } else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ),
      );
    }
  }

  Widget buildCard(BuildContext context, Barang barang) {
    return Card(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 150, maxHeight: 161),
        child: Container(
          padding: EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    decoration:
                        BoxDecoration(color: const Color.fromARGB(0, 0, 0, 0)),
                    width: 150,
                    height: 161,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0.0,
                          left: 0.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 1),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              _showCustomDialog(context, barang);
                            },
                            child: Container(
                              color: const Color.fromARGB(0, 0, 0, 0),
                              width: 150,
                              height: 124,
                              padding: EdgeInsets.all(2),
                              child: Image.network(
                                barang.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 1),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              _showCustomDialog(context, barang);
                            },
                            child: Container(
                              color: Color.fromARGB(0, 255, 255, 255),
                              width: 150,
                              height: 37,
                              padding: EdgeInsets.all(2),
                              child: Text(
                                barang.nama,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomDialog(BuildContext context, Barang barang) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  barang.nama,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    barang.image,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  barang.deskripsi,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void main() {
    runApp(Nyobagridvies());
  }
