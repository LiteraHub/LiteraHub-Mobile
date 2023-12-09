import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literahub/models/buku.dart';
import 'package:literahub/screens/daftar_buku/bookinfopage.dart';
// import 'package:literahub/widgets/list_card.dart';

class ListDaftarBuku2 extends StatefulWidget {
  const ListDaftarBuku2({Key? key}) : super(key: key);

  @override
  _ListDaftarBuku2State createState() => _ListDaftarBuku2State();
}

class _ListDaftarBuku2State extends State<ListDaftarBuku2> {
  Future<List<Buku>> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/daftarbuku/show_json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Buku'),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Color(0xFFEDECF2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  //Search Widget
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search title/author/year book here...",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //Popular book title
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Through books, we embark on adventures that transcend time and space.",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5),
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
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.68,
                                  mainAxisSpacing: 25,
                                ),
                                // physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index) => Container(
                                      child: InkWell(
                                          onTap: () {
                                            // Memunculkan SnackBar ketika diklik
                                            // Navigate ke route yang sesuai (tergantung jenis tombol)
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailBukuPage(snapshot
                                                          .data![index].pk),
                                                ));
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
                                                  // crossAxisAlignment:
                                                  //     CrossAxisAlignment
                                                  //         .stretch,
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                8.0),
                                                        topRight:
                                                            Radius.circular(
                                                                8.0),
                                                      ),
                                                      child: Image.network(
                                                        '${snapshot.data![index].fields.img}',
                                                        width: 200,
                                                        height: 250,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: RichText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          strutStyle:
                                                              StrutStyle(
                                                                  fontSize:
                                                                      10.0),
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 17,
                                                            ),
                                                            text:
                                                                '${snapshot.data![index].fields.title}',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Container(
                                                    // padding:
                                                    //     EdgeInsets.all(10),
                                                    // alignment:
                                                    //     Alignment.center,
                                                    //   child: Text(
                                                    //     "${snapshot.data![index].fields.title}",
                                                    //     style: TextStyle(
                                                    //       fontSize: 15,
                                                    //       color: Colors.black,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ]))),
                                    ));
                          }
                        }
                      })
                ],
              ),
            )
          ],
        ));
  }
}
