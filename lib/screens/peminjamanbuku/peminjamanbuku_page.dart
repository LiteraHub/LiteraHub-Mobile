import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:literahub/models/buku.dart';
import 'package:literahub/screens/peminjamanbuku/book_tersedia.dart';
import 'package:literahub/screens/peminjamanbuku/pengembalian_buku.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:literahub/screens/peminjamanbuku/form_peminjaman.dart';
import 'package:http/http.dart' as http;

class PeminjamanBukuPage extends StatefulWidget {
  PeminjamanBukuPage({Key? key}) : super(key: key);
  
  @override
  _PeminjamanBukuPageState createState() => _PeminjamanBukuPageState();
}

class _PeminjamanBukuPageState extends State<PeminjamanBukuPage> {

  Future<List<Buku>> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/peminjamanbuku/get-buku-item/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Buku> productList = [];
    for (var d in data) {
      if (d != null) {
        Buku buku = Buku.fromJson(d);
        productList.add(buku);
      }
    }
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Peminjaman Buku',
        ),
        backgroundColor: const Color(0xFFC9C5BA),
        foregroundColor: Colors.black,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Peminjaman Buku',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Ingin Meminjam Buku? Tekan Tombol dibawah ini!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PeminjamanForm()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFC9C5BA)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: const Text('Pinjam Buku')
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReturnBookPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFC9C5BA)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: const Text('Kembalikan Buku')
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Buku Tersedia',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                  future: fetchProduct(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                          child: CircularProgressIndicator());
                    } else {
                      if (!snapshot.hasData) {
                        return const Column(
                          children: [
                            Text(
                              "Tidak ada data produk.",
                              style: TextStyle(
                                  color: Color(0xff59A5D8), fontSize: 20),
                            ),
                            SizedBox(height: 8),
                          ],
                        );
                      } else {
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.5,
                            mainAxisSpacing: 8,
                          ),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute( builder: (context) => BukuTersediaPage(snapshot.data![index]),
                                  )
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 10),
                                  margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                                  decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                        BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 2/3,
                                        child: Image.network(
                                        '${snapshot.data![index].fields.img}',
                                        width: 200,
                                        height: 250,
                                        fit: BoxFit.fill,
                                        ),
                                      )   
                                    ),
                                    Expanded(
                                      child: Container(
                                      padding: EdgeInsets.all(20),
                                        child: Align( 
                                          alignment: Alignment.center,
                                          child: RichText(
                                            overflow: TextOverflow .ellipsis,
                                            maxLines: 2,
                                            strutStyle: 
                                            StrutStyle( fontSize: 10.0),
                                            text: TextSpan(
                                              style: TextStyle(
                                                color:
                                                    Colors.black,
                                                fontSize: 17,
                                              ),
                                              text: '${snapshot.data![index].fields.title}',
                                            ),
                                          ),
                                        ),
                                      ), 
                                    ),
                                  ]
                                )
                              )
                            ),
                          )
                        );
                      }
                    }
                  }
                )
            ],
          ),
        ),
      ),
    );
  }
}

