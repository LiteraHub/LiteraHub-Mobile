import 'package:flutter/material.dart';
import 'package:literahub/models/review.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../api_services/API_services.dart';


class ReviewAllBooksPage extends StatefulWidget {
  final int id;
  const ReviewAllBooksPage(this.id, {Key? key}) : super(key: key);

  @override
  _ReviewAllBooksPageState createState() => _ReviewAllBooksPageState(id);
}

class _ReviewAllBooksPageState extends State<ReviewAllBooksPage> {
  final int id;
  _ReviewAllBooksPageState(this.id);

  final FetchBook _reviewList = FetchBook();
  bool showCurrentUserReviews = false;

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Review kamu sudah dihapus'),
          ),
        );
      } catch (error) {
        // Handle errors, e.g., show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Maaf, gagal untuk menghapus. Yuk dicoba lagi'),
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
            title: const Center(
          child: Text(
            'Review Buku',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        )),
        body: ListView(children: [
          Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin:
                              EdgeInsets.only(bottom: 10, right: 10, top: 10),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.brown.shade50,
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                value: showCurrentUserReviews,
                                onChanged: (value) {
                                  setState(() {
                                    showCurrentUserReviews = value!;
                                  });
                                },
                              ),
                              Text(
                                'Review saya',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  FutureBuilder<List<Review>>(
                    future: _reviewList.getReviewBook(id: id),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (!snapshot.hasData || snapshot.data!.length == 0) {
                          return const Column(
                            children: [
                              Text(
                                "Belum ada review.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              SizedBox(height: 8),
                            ],
                          );
                        } else {
                          List<Review> reviewsToShow = snapshot.data!;
                          if (showCurrentUserReviews) {
                            // Filter reviews based on the current user
                            reviewsToShow = reviewsToShow
                                .where((review) => request
                                    .getJsonData()
                                    .containsValue(review.fields.username))
                                .toList();
                          }
                          if (reviewsToShow.length == 0 || !snapshot.hasData) {
                            return const Column(
                              children: [
                                Text(
                                  "Belum ada review dari kamu nih. Isi dulu yuk!",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                SizedBox(height: 8),
                              ],
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: reviewsToShow.length,
                                // snapshotReview.data!.length
                                itemBuilder: (_, index) => Container(
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    // padding: const EdgeInsets.only(
                                    //     left: 5, right: 5, top: 5),
                                    // margin: const EdgeInsets.symmetric(
                                    //     vertical: 8, horizontal: 8),
                                    child: Column(children: [
                                      //Reiview buku per satu orang
                                      Container(
                                          alignment: Alignment.topLeft,
                                          // padding: const EdgeInsets.symmetric(
                                          //     vertical:
                                          //         10,
                                          //     horizontal:
                                          //         10),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          margin:
                                              const EdgeInsets.only(bottom: 25),
                                          decoration: BoxDecoration(
                                            color: Colors.brown.shade50,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  alignment: Alignment.center,
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    color: Colors.brown.shade50,
                                                  ),
                                                  child: Icon(
                                                    Icons
                                                        .account_circle_rounded,
                                                    size: 35.0,
                                                  )),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 7),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .brown.shade50,
                                                        ),
                                                        child: Text(
                                                          '${reviewsToShow[index].fields.username}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 3),
                                                        alignment:
                                                            Alignment.topLeft,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .brown.shade50,
                                                        ),
                                                        child: Text(
                                                          '${reviewsToShow[index].fields.review}',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Spacer(),
                                              if (request
                                                  .getJsonData()
                                                  .containsValue(
                                                      reviewsToShow[index]
                                                          .fields
                                                          .username))
                                                InkWell(
                                                  onTap: () async {
                                                    // Implementasi logika hapus review di sini
                                                    // Misalnya, panggil fungsi hapusReview(reviewsToShow[index].id)
                                                    await hapusReview(
                                                        reviewsToShow[index]
                                                            .pk);
                                                  },
                                                  child: Container(
                                                    // padding: EdgeInsets.all(8),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      // color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              244,
                                                              101,
                                                              101),
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          )),
                                    ])));
                          }
                        }
                      }
                    },
                  ),
                ],
              )),
        ]));
  }
}
