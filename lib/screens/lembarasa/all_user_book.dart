import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:literahub/models/buku.dart';
import 'dart:convert';
import 'package:literahub/models/mybuku.dart';
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
                                "http://127.0.0.1:8000/lembar-asa/json-mybuku-user/",
                                jsonEncode(<String, String>{
                                    'name':'bait',
                                }));


    // melakukan konversi data json menjadi object MyBuku
    List<MyBuku> list_mybuku = [];
    for (var d in data) {
      if (d != null) {
        list_mybuku.add(MyBuku.fromJson(d));
      }
    }
    return list_mybuku;
  }

  Future<List<Buku>> fetchBuku() async {
    var url = Uri.parse('http://127.0.0.1:8000/lembar-asa/json-buku/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

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
        backgroundColor: Colors.purple.shade900,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: Future.wait([fetchMyBuku(request), fetchBuku()]),
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
                          "${myBukuList[index].fields.user}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(myBukuList[index].fields.isi),
                        const SizedBox(height: 10),
                        Text("${myBukuList[index].fields.buku}"),
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
