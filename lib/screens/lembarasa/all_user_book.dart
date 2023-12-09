import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:literahub/models/buku.dart';
import 'dart:convert';
import 'package:literahub/models/mybuku.dart';
import 'package:literahub/screens/lembarasa/detail_isi_buku.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MyBukuPage extends StatefulWidget {
  const MyBukuPage({Key? key}) : super(key: key);

  @override
  _MyBukuPageState createState() => _MyBukuPageState();
}

class _MyBukuPageState extends State<MyBukuPage> {
  Future<List<MyBuku>> fetchMyBuku(CookieRequest request) async {
    final data = await request.postJson(
                                "http://127.0.0.1:8000/lembar-asa/json-mybuku/",
                                jsonEncode(<String, String>{}));

    // melakukan konversi data json menjadi object MyBuku
    List<MyBuku> list_mybuku = [];
    for (var d in data) {
      if (d != null) {
        list_mybuku.add(MyBuku.fromJson(d));
      }
    }
    return list_mybuku;
  }

  Future<List<Buku>> fetchBuku(CookieRequest request) async {
    final data = await request.postJson(
                                "http://127.0.0.1:8000/lembar-asa/get-semua-buku/",
                                jsonEncode(<String, String>{}));

    // melakukan konversi data json menjadi object Buku
    List<Buku> list_buku = [];
    for (var d in data) {
      if (d != null) {
        list_buku.add(Buku.fromJson(d));
      }
    }
    return list_buku;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Semua buku user',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFC9C5BA),
      ),
      // drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: Future.wait([fetchMyBuku(request), fetchBuku(request)]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<MyBuku> myBukuList = snapshot.data![0];
            List<Buku> bukuList = snapshot.data![1];

            if (bukuList.isEmpty) {
              return const Center(child: Text('Tidak ada data mybuku.'));
            } else {
              return ListView.builder(
                itemCount: bukuList.length,
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailBuku(buku: bukuList[index],myBuku: myBukuList[index]),
                      ),
                    );                  
                  },
                  child : Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0
                        )
                      ]
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child : ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: Image.network(
                                bukuList[index].fields.img, // Replace with the actual image URL
                                width: 80, // Adjust the width as needed
                                height: 120, // Adjust the height as needed
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                bukuList[index].fields.title,
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(bukuList[index].fields.author),
                              const SizedBox(height: 10),
                              Text("${bukuList[index].fields.year}"),
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                )
              );
            }
          }
        },
      ),
    );
  }
}
