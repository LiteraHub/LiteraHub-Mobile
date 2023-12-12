import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:literahub/models/buku.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import '../../../models/review.dart';

class FetchBook {
  List<Buku> list_buku = [];
  List<Review> list_review = [];
  List<String> list_username = [];
  String user = "";

  Future<List<Buku>> getBookList({String? query}) async {
    list_buku.clear();
    var url = Uri.parse("http://localhost:8000/daftarbuku/show_json/");
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    print("apa");
    print(query);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    for (var d in data) {
      if (d != null) {
        list_buku.add(Buku.fromJson(d));
      }
    }

    if (query != null) {
      print("masuk");
      list_buku = list_buku
          .where((element) =>
              element.fields.title.toLowerCase().contains(query) ||
              element.fields.author.toLowerCase().contains(query) ||
              element.fields.year.toString().contains(query))
          .toList();
      print(list_buku.length);
    }

    return list_buku;
  }

  Future<List<Buku>> getBookInfo({int? id}) async {
    list_buku.clear();
    var url =
        Uri.parse('http://localhost:8000/daftarbuku/show_json_by_id/$id/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    for (var d in data) {
      if (d != null) {
        list_buku.add(Buku.fromJson(d));
      }
    }
    return list_buku;
  }

  Future<List<Review>> getReviewBook({int? id}) async {
    list_review.clear();
    var url = Uri.parse(
        'http://localhost:8000/daftarbuku/get_review_json_by_id/$id/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    data.sort((a, b) {
      var timeA = DateTime.parse(a['fields']['created_at']);
      var timeB = DateTime.parse(b['fields']['created_at']);
      return timeB.compareTo(timeA);
    });

    // melakukan konversi data json menjadi object Product
    for (var d in data) {
      if (d != null) {
        list_review.add(Review.fromJson(d));
      }
    }
    return list_review;
  }

  // Future<String> fetchUser({required CookieRequest request}) async {
  //   final response = await request.postJson(
  //       'http://localhost:8000/daftarbuku/user_detail_view/',
  //       jsonEncode(<String, String>{
  //         'pk': '2',
  //       }));

  //   // melakukan decode response menjadi bentuk json
  //   var data = response['user'];
  //   print(data);
  //   return data;
  // }

  Future<http.Response> removeReview({int? pk}) async {
    final http.Response response = await http.delete(Uri.parse(
      'http://localhost:8000/daftarbuku/delete_review_by_id/$pk'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    return response;
  }
}
