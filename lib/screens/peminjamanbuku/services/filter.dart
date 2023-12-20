import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:literahub/models/buku.dart';
import 'package:literahub/models/peminjaman_buku.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class Filter{

  Future<List<Buku>> getFiltered({String? query}) async {
  List<Buku> filteredBook = [];
  var url = Uri.parse('https://literahub-e08-tk.pbp.cs.ui.ac.id/peminjamanbuku/get-buku-item/');
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
          filteredBook.add(buku);
        }
      } else {
        filteredBook.add(buku);
      }
    }
  }
    return filteredBook;
  }

  Future<List<PeminjamanBuku>> getFilteredPeminjaman({CookieRequest? request, String? search}) async {
    List<PeminjamanBuku> filteredPeminjaman = [];
    final response = await request?.get("https://literahub-e08-tk.pbp.cs.ui.ac.id/peminjamanbuku/get-pinjem/");
    for (var d in response) {
        if (d != null) {
          PeminjamanBuku peminjaman = PeminjamanBuku.fromJson(d);
          if(search != null){
            if(peminjaman.fields.title.toLowerCase().contains(search)){
              filteredPeminjaman.add(peminjaman);
            }
          } else {
            filteredPeminjaman.add(peminjaman);
          }
        }
    }
    return filteredPeminjaman;
  }
}