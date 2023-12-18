import 'package:flutter/material.dart';
import 'package:literahub/models/buku.dart';
import 'package:literahub/models/review.dart';
import 'package:literahub/screens/daftar_buku/detail_buku/review_buku.dart';
import 'package:literahub/screens/daftar_buku/detail_buku/review_form.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../api_services/API_services.dart';

class DetailBukuPage extends StatefulWidget {
  final int id;
  const DetailBukuPage(this.id, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _DetailBukuPageState createState() => _DetailBukuPageState(id);
}

class _DetailBukuPageState extends State<DetailBukuPage> {
  final int id;
  _DetailBukuPageState(this.id);

  final FetchBook _bookList = FetchBook();
  final FetchBook _reviewList = FetchBook();

  Future<void> _refreshData() async {
    bool flag = true;
    try {
      // Fetch the reviews again using _reviewList.getReviewBook
      List<Review> refreshedReviews = await _reviewList.getReviewBook(id: id);

      if (refreshedReviews.isNotEmpty) {
        // Update the state with the refreshed reviews
        setState(() {
          if (refreshedReviews[0].pk != _reviewList.list_review[0].pk) {
            _reviewList.list_review.clear();
            _reviewList.list_review = refreshedReviews;
          } else {
            flag = false;
          }
        });

        if (flag == true) {
          // Show a message to indicate successful refresh
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Review sudah diperbarui'),
            ),
          );
        }
      }
    } catch (error) {
      // Handle errors, e.g., show an error message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memperbarui review'),
        ),
      );
    }
  }

  Future<void> hapusReview(int pk) async {
    final http.Response response = await http.delete(
        Uri.parse('https://literahub-e08-tk.pbp.cs.ui.ac.id/daftarbuku/delete_review_by_id/$pk/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      try {
        // Fetch the reviews again using _reviewList.getReviewBook
        List<Review> refreshedReviews = await _reviewList.getReviewBook(id: id);

        // Update the state with the refreshed reviews
        setState(() {
          _reviewList.list_review.clear();
          // Assuming you have a variable to store reviews in your state
          _reviewList.list_review = refreshedReviews;
        });

        // Show a message to indicate successful refresh
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Review kamu sudah dihapus'),
          ),
        );
      } catch (error) {
        // Handle errors, e.g., show an error message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to refresh reviews.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detail Buku',
            style: TextStyle(
            fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: const Color.fromARGB(255, 42, 33, 0),
          backgroundColor: const Color(0xFFC9C5BA),
        ),
        body: ListView(children: [
          Container(
              //Temporary height
              // height: 500,
              // padding: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: FutureBuilder<List<Buku>>(
                  future: _bookList.getBookInfo(id: id),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (!snapshot.hasData || snapshot.data!.length == 0) {
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
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Column(
                              children: [
                                  //Buat gambar, keterangan buku
                              Container(
                              decoration: BoxDecoration(
                              color: Colors.brown.shade50,
                            ),
                            child: Column(children: [
                              //Gambar
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.brown.shade50,
                                    borderRadius:
                                        BorderRadius.circular(20),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 7 / 6,
                                    child: Image.network(
                                      '${snapshot.data![index].fields.img}',
                                      // width: 500,
                                      // height: 300,
                                      fit: BoxFit.contain,
                                    ),
                                  )),
                              const SizedBox(height: 10),

                              //detail buku
                              Container(
                                  // alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  // decoration: BoxDecoration(
                                  //   color: Colors.amberAccent,
                                  // ),
                                  child: Column(children: [
                                    //Judul Buku
                                    Container(
                                        margin: const EdgeInsets.only(
                                            top: 10),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: Colors.brown.shade50,
                                        ),
                                        child: Text(
                                          '${snapshot.data![index].fields.title}',
                                          style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),

                                    //Author buku
                                    Container(
                                        margin: const EdgeInsets.only(
                                            top: 10),
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: Colors.brown.shade50,
                                        ),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Author  :",
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            Container(
                                                margin: const EdgeInsets
                                                    .only(left: 3),
                                                child: Text(
                                                  '${snapshot.data![index].fields.author}',
                                                  style:
                                                      const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                )),
                                          ],
                                        )),

                                    //Year buku
                                    Container(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: Colors.brown.shade50,
                                        ),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Year      :",
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            Container(
                                                margin: const EdgeInsets
                                                    .only(left: 3),
                                                child: Text(
                                                  '${snapshot.data![index].fields.year}',
                                                  style:
                                                      const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                )),
                                          ],
                                        )),

                                    //ISBN buku
                                    Container(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: Colors.brown.shade50,
                                        ),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "ISBN     :",
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            Container(
                                                margin: const EdgeInsets
                                                    .only(left: 3),
                                                child: Text(
                                                  '${snapshot.data![index].fields.isbn}',
                                                  style:
                                                      const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                )),
                                          ],
                                        )),
                                    //button
                                    Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 30),
                                        alignment: Alignment.bottomLeft,
                                        decoration: BoxDecoration(
                                          color: Colors.brown.shade50,
                                        ),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                              // alignment: Alignment.center,
                                              // width: MediaQuery.of(context).size.width / 3,
                                              margin:
                                                  const EdgeInsets.only(
                                                      top: 20),
                                              padding:
                                                  const EdgeInsets.only(
                                                      left: 30,
                                                      right: 30,
                                                      top: 5,
                                                      bottom: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors
                                                          .red.shade400,
                                                      blurRadius: 1,
                                                      spreadRadius: 1,
                                                    )
                                                  ]),
                                              child: Row(
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    alignment: Alignment
                                                        .center,
                                                    child:
                                                        Image.network(
                                                      '${snapshot.data![index].fields.img}',
                                                      height: 33,
                                                      width: 33,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets
                                                                .only(
                                                            left: 15),
                                                    alignment: Alignment
                                                        .center,
                                                    child: const Text(
                                                      "Pinjam Sekarang",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Prompt',
                                                        color: Colors
                                                            .white,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ))
                                  ]))
                            ]),
                                  ),
                                  Column(
                            children: [
                            //Buat Review
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  //Tulisan Review Buku
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 40),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: const Text(
                                      "Review Buku",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  //Kumpulan review buku (Rencananya nampilin 5 saja)
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: FutureBuilder<
                                            List<Review>>(
                                        future: _reviewList
                                            .getReviewBook(id: id),
                                        builder: (context,
                                            AsyncSnapshot
                                                snapshotReview) {
                                          if (snapshotReview.data ==
                                              null) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            if (!snapshotReview
                                                    .hasData ||
                                                snapshotReview.data!
                                                        .length ==
                                                    0) {
                                              return const Column(
                                                children: [
                                                  Text(
                                                    "Belum ada review.",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                      height: 50),
                                                ],
                                              );
                                            } else {
                                              return ListView.builder(
                                                  // physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshotReview
                                                              .data!
                                                              .length >=
                                                          3
                                                      ? 3
                                                      : snapshotReview
                                                          .data!
                                                          .length,
                                                  // snapshotReview.data!.length
                                                  itemBuilder: (_,
                                                          index) =>
                                                      Container(
                                                          alignment:
                                                              Alignment
                                                                  .topLeft,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors
                                                                .white,
                                                          ),
                                                          // padding: const EdgeInsets.only(
                                                          //     left: 5, right: 5, top: 5),
                                                          // margin: const EdgeInsets.symmetric(
                                                          //     vertical: 8, horizontal: 8),
                                                          child: Column(
                                                              children: [
                                                                //Reiview buku per satu orang
                                                                Container(
                                                                    alignment: Alignment.topLeft,
                                                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                                    margin: const EdgeInsets.only(bottom: 25),
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.brown.shade50,
                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                    ),
                                                                    child: Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Container(
                                                                            alignment: Alignment.center,
                                                                            height: 35,
                                                                            width: 35,
                                                                            decoration: BoxDecoration(
                                                                              color: Colors.brown.shade50,
                                                                            ),
                                                                            child: const Icon(
                                                                              Icons.account_circle_rounded,
                                                                              size: 35.0,
                                                                            )),
                                                                        Container(
                                                                            margin: const EdgeInsets.only(left: 7),
                                                                            child: Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Container(
                                                                                  alignment: Alignment.topLeft,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.brown.shade50,
                                                                                  ),
                                                                                  child: Text(
                                                                                    '${snapshotReview.data![index].fields.username}',
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  margin: const EdgeInsets.only(top: 3),
                                                                                  alignment: Alignment.topLeft,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.brown.shade50,
                                                                                  ),
                                                                                  child: Text(
                                                                                    '${snapshotReview.data![index].fields.review}',
                                                                                    style: const TextStyle(
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                        const Spacer(),
                                                                        if (request.getJsonData().containsValue(snapshotReview.data![index].fields.username))
                                                                          InkWell(
                                                                            onTap: () async {
                                                                              // Implementasi logika hapus review di sini
                                                                              // Misalnya, panggil fungsi hapusReview(reviewsToShow[index].id)
                                                                              await hapusReview(snapshotReview.data![index].pk);
                                                                            },
                                                                            child: Container(
                                                                              // padding: EdgeInsets.all(8),
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(
                                                                                // color: Colors.red,
                                                                                borderRadius: BorderRadius.circular(5),
                                                                              ),
                                                                              child: const Icon(
                                                                                Icons.delete,
                                                                                color: Color.fromARGB(255, 244, 101, 101),
                                                                                size: 20.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      ],
                                                                    )),
                                                              ])));
                                            }
                                          }
                                        }),
                                  )
                                ],
                              ),
                            ),

                            //Buat tombol tampilkan review lainnya
                            Container(
                                alignment: Alignment.bottomCenter,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReviewAllBooksPage(id),
                                        ));
                                    await _refreshData();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        right: 30,
                                        top: 5,
                                        bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.red.shade400,
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                          )
                                        ]),
                                    child: const Text(
                                      "Lihat Semua Komentar",
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )),
                            //Buat tombol add review
                            Container(
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 30),
                                alignment: Alignment.bottomCenter,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReviewFormPage(id),
                                        ));
                                    await _refreshData();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        right: 30,
                                        top: 5,
                                        bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.red.shade400,
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                          )
                                        ]),
                                    child: const Text(
                                      "Tambahkan Review",
                                      style: TextStyle(
                                        fontFamily: 'Prompt',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )),
                                  ])
                                ]));
                      }
                    }
                  }))
        ]));
  }
}
