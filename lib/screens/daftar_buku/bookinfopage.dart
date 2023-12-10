import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literahub/models/buku.dart';

class DetailBukuPage extends StatefulWidget {
  final int id;
  const DetailBukuPage(this.id, {Key? key}) : super(key: key);

  @override
  _DetailBukuPageState createState() => _DetailBukuPageState(id);
}

class _DetailBukuPageState extends State<DetailBukuPage> {
  final int id;
  _DetailBukuPageState(this.id);
  Future<List<Buku>> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/daftarbuku/show_json_by_id/$id/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Buku> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Buku.fromJson(d));
      }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: const Text(
              'LiteraHub',
              style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              ),
            ),
          )
        ),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data produk.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Title : ${snapshot.data![index].fields.title}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                    "Img : ${snapshot.data![index].fields.img}"),
                                const SizedBox(height: 10),
                                Text(
                                    "Isbn : ${snapshot.data![index].fields.isbn}"),
                                Text(
                                    "Author : ${snapshot.data![index].fields.author}"),
                                Text(
                                    "Year : ${snapshot.data![index].fields.year}"),
                              ],
                            ),
                          ));
                }
              }
            }));
  }
}
