import 'package:flutter/material.dart';
import 'package:paa_project/nyobagridvies.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgetfolder/cuacadetail_widget.dart';
import 'widgetfolder/cuaca_widget.dart';
import 'post_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String searchTerm = "";
  PostMod? postMod;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      postMod = await PostMod.connectToAPI();
    } catch (error) {
      errorMessage = error.toString();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2196F3),
        actions: [],
      ),
      body: Container(
        color: Colors.blue,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Row(
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationZ(-math.pi / 18.0 * 0),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 0, left: 65, right: 0),
                          child: Container(
                            width: 114,
                            height: 111,
                            padding: EdgeInsets.all(2),
                            child: Image.asset(
                              'images/cuaca1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationZ(-math.pi / 18.0 * 0),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 66.51, bottom: 0, left: 60, right: 0),
                          child: Container(
                            color: const Color.fromARGB(0, 0, 0, 0),
                            width: 107,
                            height: 107,
                            padding: EdgeInsets.all(2),
                            child: Image.asset(
                              'images/cuaca2.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: SizedBox(
                      width: 360,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 174, bottom: 0, left: 0, right: 0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(54.0),
                            topRight: Radius.circular(54.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 39),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 79,
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: WeatherIconWidget(
                                          cityName: 'samarinda'),
                                    ),
                                    SizedBox(width: 17),
                                    Container(
                                      child: WeatherInfoCard(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 70),
                                    Text(
                                      'Rekomendasi Makan & Minuman:',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF3F3F3F)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 338,
                                  height: 280,
                                  child: Nyobagridvies(),
                                ),
                                SizedBox(height: 39),
                                Container(
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
