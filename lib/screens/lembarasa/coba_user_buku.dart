import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:literahub/models/buku.dart';
import 'dart:convert';
import 'package:literahub/models/mybuku.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CobaMyBukuPage extends StatefulWidget {
  const CobaMyBukuPage({Key? key}) : super(key: key);

  @override
  _CobaMyBukuPageState createState() => _CobaMyBukuPageState();
}

class _CobaMyBukuPageState extends State<CobaMyBukuPage> {
  Future<List<MyBuku>> fetchMyBuku(CookieRequest request) async {
    final data = await request.postJson(
                                "http://127.0.0.1:8000/lembar-asa/json-mybuku-user/",
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
                                "http://127.0.0.1:8000/lembar-asa/get-buku/",
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
          'buku user',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFC9C5BA),
      ),
      drawer: const LeftDrawer(),
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

            if (myBukuList.isEmpty) {
              return const Center(child: Text('Tidak ada data mybuku.'));
            } else {
              return ListView.builder(
                itemCount: myBukuList.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    // Navigasi ke halaman detail dengan data yang sesuai
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DetailItem(item : snapshot.data![index]),
                    //   ),
                    // );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bukuList[index].fields.title,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(bukuList[index].fields.author),
                        const SizedBox(height: 10),
                        Text("${bukuList[index].fields.year}"),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
