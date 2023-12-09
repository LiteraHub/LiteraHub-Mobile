import 'package:flutter/material.dart';
import 'package:literahub/models/peminjaman_buku.dart';
import 'package:literahub/screens/peminjamanbuku/book_detail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
// import 'package:literahub/widgets/list_card.dart';

class ReturnBookPage extends StatefulWidget {
  const ReturnBookPage({Key? key}) : super(key: key);

  @override
  _ReturnBookPageState createState() => _ReturnBookPageState();
}

class _ReturnBookPageState extends State<ReturnBookPage> {

  Future<List<PeminjamanBuku>> fetchProduct(CookieRequest request) async {
    final response = await request.get(
      "http://127.0.0.1:8000/peminjamanbuku/get-pinjem/",
    );
    List<PeminjamanBuku> list_product = [];
    for (var d in response) {
        if (d != null) {
            list_product.add(PeminjamanBuku.fromJson(d));
        }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Halaman Pengembalian',
          ),
          backgroundColor: const Color(0xFFC9C5BA),
          foregroundColor: Colors.black,
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
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Silahkan mengembalikan buku dengan klik gambar buku",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                      future: fetchProduct(request),
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
                                      MaterialPageRoute( builder: (context) => BookDetailPage(snapshot.data![index]),
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
                                            '${snapshot.data![index].fields.gambarBuku}',
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
          )
        ],
      )
    );
  }
}