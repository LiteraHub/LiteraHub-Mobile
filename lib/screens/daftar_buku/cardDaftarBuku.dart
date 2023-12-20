// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:literahub/models/buku.dart';
import 'package:literahub/screens/daftar_buku/api_services/API_services.dart';
import 'package:literahub/screens/daftar_buku/detail_buku/detail_buku.dart';
import 'package:literahub/widgets/left_drawer.dart';

class CardDaftarBuku extends StatefulWidget {
  const CardDaftarBuku({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CardDaftarBukuState createState() => _CardDaftarBukuState();
}

class _CardDaftarBukuState extends State<CardDaftarBuku> {
  final FetchBook _bookList = FetchBook();
  // ignore: prefer_typing_uninitialized_variables
  var query;

  void updateList(String value) {
    String searchTerm = value.trim().toLowerCase();
    setState(() {
      if (query != "") {
        query = searchTerm;
      } else {
        query = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Buku',
          style: TextStyle(
              fontWeight: FontWeight.bold,
            ),        
          ),
          foregroundColor: const Color.fromARGB(255, 42, 33, 0),
          backgroundColor: const Color(0xFFC9C5BA),
        ),
        drawer: const LeftDrawer(),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 242, 238, 227),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  //Search Widget
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            onChanged: (value) => updateList(value),
                            decoration: const InputDecoration(
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Text(
                      "Through books, we embark on adventures that transcend time and space.",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                  ),

                  FutureBuilder<List<Buku>>(
                      future: _bookList.getBookList(query: query),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          if (!snapshot.hasData || snapshot.data!.length == 0) {
                            return const Column(
                              children: [
                                Text(
                                  "Tidak ada buku.",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                SizedBox(height: 1000),
                              ],
                            );
                          } else {
                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.55,
                                  mainAxisSpacing: 25,
                                ),
                                // physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index) => InkWell(
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
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, top: 10),
                                        margin:
                                            const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.brown,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                            children: [
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.amber,
                                                  ),
                                                  child: AspectRatio(
                                                    aspectRatio: 2 / 3,
                                                    child: Image.network(
                                                      snapshot
                                                          .data![index].fields.img,
                                                      fit: BoxFit.cover,
                                                      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                                                      errorBuilder: (context, error,StackTrace) {
                                                        return Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.amber,
                                                          ),
                                                          child: const AspectRatio(
                                                            aspectRatio: 2 / 3,
                                                            child: Icon(
                                                              Icons
                                                                  .no_photography_outlined,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(
                                                        20),
                                                child: Align(
                                                  alignment:
                                                      Alignment.center,
                                                  child: RichText(
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    maxLines: 2,
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize:
                                                                10.0),
                                                    text: TextSpan(
                                                      style:
                                                          const TextStyle(
                                                        color:
                                                            Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                      text:
                                                          '${snapshot.data![index].fields.title}',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]))));
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
