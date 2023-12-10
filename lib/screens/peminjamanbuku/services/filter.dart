import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:literahub/models/buku.dart';
import 'package:literahub/models/peminjaman_buku.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class Filter{
  List<Buku> filtered_book = [];
  List<PeminjamanBuku> filtered_peminjaman = [];

  Future<List<Buku>> getFiltered({String? query}) async {
  filtered_book.clear();
  var url = Uri.parse('http://127.0.0.1:8000/peminjamanbuku/get-buku-item/');
  var response = await http.get(
    url,
    headers: {"Content-Type": "application/json"},
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));
  // melakukan konversi data json menjadi object Product
  for (var d in data) {
    if (d != null) {
      Buku buku = Buku.fromJson(d);
      if(query != null){
        if(buku.fields.title.toLowerCase().contains(query)){
          filtered_book.add(buku);
        }
      } else {
        filtered_book.add(buku);
      }
    }
  }
    return filtered_book;
  }

  Future<List<PeminjamanBuku>> getFilteredPeminjaman({CookieRequest? request, String? search}) async {
    final response = await request?.get("http://127.0.0.1:8000/peminjamanbuku/get-pinjem/");
    for (var d in response) {
        if (d != null) {
          PeminjamanBuku peminjaman = PeminjamanBuku.fromJson(d);
          if(search != null){
            if(peminjaman.fields.title.toLowerCase().contains(search)){
              filtered_peminjaman.add(peminjaman);
            }
          } else {
            filtered_peminjaman.add(peminjaman);
          }
        }
    }
    return filtered_peminjaman;
  }
}