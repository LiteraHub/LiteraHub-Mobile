import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literahub/models/buku.dart';
import 'package:literahub/deletesoon/daftarbukupage.dart';
// import 'package:literahub/widgets/list_card.dart';

class ListDaftarBuku extends StatefulWidget {
  const ListDaftarBuku({Key? key}) : super(key: key);

  @override
  _ListDaftarBukuState createState() => _ListDaftarBukuState();
}

class _ListDaftarBukuState extends State<ListDaftarBuku> {
  Future<List<Buku>> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/daftarbuku/show_json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Buku> listBuku = [];
    for (var d in data) {
      if (d != null) {
        listBuku.add(Buku.fromJson(d));
      }
    }
    return listBuku;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item'),
      ),
      body: FutureBuilder(
        future: fetchProduct(),
        builder: (context, AsyncSnapshot snapshot){
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
              } 
              else {
                return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        margin:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            // DaftarBukuPage(snapshot.data![index]),
                            SizedBox.fromSize(
                              size: const Size.fromHeight(120), // Set the desired height
                              child: DaftarBukuPage(snapshot.data![index]),
                            ),
                          ],
                        )
                      )
                );
              }
            }
        }
                
                
                
                
                
                
                
                
                
                
                
        //         Material(
        //           child: Column(
        //             children: [
        //               Container(
        //                 child: GridView.builder(
        //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                     crossAxisCount: 2,
        //                     childAspectRatio: 0.68,
        //                     mainAxisSpacing: 25,
        //                   ),
        //                   //disable scroll of gridview so use scroll from listview of list_daftarbuku
        //                   physics: NeverScrollableScrollPhysics(),
        //                   shrinkWrap: true,
        //                   itemCount: 8,
        //                   itemBuilder: (context, index) {
        //                     return GestureDetector(
        //                       onTap: () {},
        //                       child: Container(
        //                           padding:
        //                               EdgeInsets.only(left: 15, right: 15, top: 10),
        //                           margin:
        //                               EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        //                           decoration: BoxDecoration(
        //                             color: Colors.white,
        //                             borderRadius: BorderRadius.circular(20),
        //                           ),
        //                           child: Column(
        //                             children: [
        //                               // DaftarBukuPage(snapshot.data![index]),
        //                               SizedBox.fromSize(
        //                                 size: Size.fromHeight(120), // Set the desired height
        //                                 child: DaftarBukuPage(snapshot.data![index]),
        //                               ),
        //                             ],
        //                           )),
        //                     );
        //                   }
        //                 )
        //               )
        //             ]
        //           ),
        //         );
        //       }
        //     }
        // },
      ),
    );
  }
}