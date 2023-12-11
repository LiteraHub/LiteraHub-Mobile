// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:literahub/models/buku.dart';
import 'package:literahub/models/mybuku.dart';
import 'package:literahub/screens/lembarasa/detail_isi_buku.dart';
import 'package:literahub/screens/lembarasa/lembarasa_main.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class UserMyBukuPage extends StatefulWidget {
  const UserMyBukuPage({Key? key}) : super(key: key);

  @override
  _UserMyBukuPageState createState() => _UserMyBukuPageState();
}

class _UserMyBukuPageState extends State<UserMyBukuPage> {
  Future<List<MyBuku>> fetchMyBuku(CookieRequest request) async {
    var data = await request.get("http://127.0.0.1:8000/lembar-asa/json-mybuku-user/");

    List<MyBuku> listMybuku = [];
    for (var d in data) {
      if (d != null) {
        listMybuku.add(MyBuku.fromJson(d));
      }
    }
    return listMybuku;
  }

  Future<List<Buku>> fetchBuku(CookieRequest request) async {
    var data = await request.get("http://127.0.0.1:8000/lembar-asa/get-buku/");

    List<Buku> listBuku = [];
    for (var d in data) {
      if (d != null) {
        listBuku.add(Buku.fromJson(d));
      }
    }
    return listBuku;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    var mapJsonData = request.jsonData;
    var username = mapJsonData['username'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Karya $username',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: const Color.fromARGB(255, 42, 33, 0),
        backgroundColor: const Color(0xFFC9C5BA),
      ),
      backgroundColor: const Color.fromARGB(255, 242,238,227),
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
              return const Center(child: Text('Ayo unggah karyamu!'));
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
                      borderRadius: BorderRadius.circular(17.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
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
                                bukuList[index].fields.img,
                                width: 80,
                                height: 120,
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
                              Text("${bukuList[index].fields.year}"),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  title: const Text("Hapus Buku"),
                                  content: const Text("Apakah anda yakin ingin menghapus buku ini?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Tidak",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        var url = "http://127.0.0.1:8000/lembar-asa/delete-flutter/";
                                        final response = await request.postJson(
                                          url, 
                                          jsonEncode(<String, int>{
                                            'id':bukuList[index].pk,
                                          }));
                                        if (response['status'] == 'success') {
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => const LembarAsaMain()),
                                          );
                                        }
                                      },
                                      child: const Text(
                                        "Hapus",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
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
