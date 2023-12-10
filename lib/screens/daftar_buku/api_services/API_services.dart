import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:literahub/models/buku.dart';

class FetchBook{
  List<Buku> list_buku = [];

  String fetchurl = "http://127.0.0.1:8000/daftarbuku/show_json/";

  Future<List<Buku>> getBookList({String? query}) async {
    list_buku.clear();
    var url = Uri.parse(fetchurl);
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

    if(query != null){
      print("masuk");
      list_buku = list_buku
          .where((element) =>
              element.fields.title.toLowerCase().contains(query) ||
              element.fields.author.toLowerCase().contains(query) ||
              element.fields.year.toString().contains(query))
          .toList();
    }

    return list_buku;
  }
}