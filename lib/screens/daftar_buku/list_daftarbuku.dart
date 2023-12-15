import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literahub/models/buku.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:literahub/screens/daftar_buku/daftarbukupage.dart';
// import 'package:literahub/widgets/list_card.dart';

class ListDaftarBuku extends StatefulWidget {
  const ListDaftarBuku({Key? key}) : super(key: key);

  @override
  _ListDaftarBukuState createState() => _ListDaftarBukuState();
}

class _ListDaftarBukuState extends State<ListDaftarBuku> {
  var height, width;

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
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Buku',
        ),
      ),
      drawer: const LeftDrawer(),
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
                return Material(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.brown.shade50,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        height: height * 0.75,
                        width: width,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            childAspectRatio: 1.1,
                            mainAxisSpacing: 25,
                          ),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 1, vertical: 12),
                            padding: const EdgeInsets.all(10.0),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  DaftarBukuPage(snapshot.data![index])
                                ],
                              ),
                            )
                          )
                        )
                      )
                    ]
                  )
                );



                // return GridView.builder(
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 2,
                //         childAspectRatio: 1.1,
                //         mainAxisSpacing: 25,
                //       ),
                //   shrinkWrap: true,
                //   itemCount: snapshot.data!.length,
                //   itemBuilder: (_, index) => Container(
                //         margin: const EdgeInsets.symmetric(
                //             horizontal: 16, vertical: 12),
                //         padding: const EdgeInsets.all(20.0),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [DaftarBukuPage(snapshot.data![index])],
                //         ),
                //       ));
              }
            }
          }
      )
    );













    // height = MediaQuery.of(context).size.height;
    // width = MediaQuery.of(context).size.width;
    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Daftar Buku'),
    //     ),
    //     drawer: const LeftDrawer(),
    //     body: Container(
    //       color: Colors.brown.shade50,
    //       height: height,
    //       width: width,
    //       child: Column(
    //         children: [
    //           Container(
    //             decoration: BoxDecoration(
    //               color: Colors.brown.shade50,
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(30),
    //                 topRight: Radius.circular(30),
    //               ),
    //             ),
    //             height: height * 0.75,
    //             width: width,
    //             child: GridView.builder(
    //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                 crossAxisCount: 2,
    //                 childAspectRatio: 1.1,
    //                 mainAxisSpacing: 25,
    //               ),
    //               shrinkWrap: true,
    //               // physics: NeverScrollableScrollPhysics(),
    //               itemCount: 6,
    //               itemBuilder: (context, index){
    //                 return InkWell(
    //                   onTap: (){},
    //                   child: Container(
    //                     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(20),
    //                       color: Colors.white,
    //                       boxShadow: [
    //                         BoxShadow(
    //                           color: Colors.black26,
    //                           spreadRadius: 1,
    //                           blurRadius: 1,
    //                         ),
    //                       ],
    //                     ),
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       // children: [
    //                       //   Image.asset(
    //                       //     imgData[index],
    //                       //     width: 100,
    //                       //   )
    //                       // ],
    //                     ),
    //                   ),
    //                 );
    //               },
    //             ),
    //           )
    //         ],
    //       ),
    //     )
  }
}
