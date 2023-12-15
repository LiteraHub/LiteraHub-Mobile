import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:literahub/models/buku.dart';
import 'package:literahub/models/peminjaman_buku.dart';
import 'package:literahub/screens/peminjamanbuku/peminjamanbuku_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatefulWidget {
  final PeminjamanBuku objekPinjam;
  const BookDetailPage(this.objekPinjam, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<BookDetailPage> createState() => _BookDetailPageState(objekPinjam, objekPinjam.fields.buku);
}

class _BookDetailPageState extends State<BookDetailPage>{
  final PeminjamanBuku objek;
  final int idBuku;
  _BookDetailPageState(this.objek, this.idBuku);

  Future<List<Buku>> fetchProduct(CookieRequest request) async {
      final response = await request.get(
        "https://literahub-e08-tk.pbp.cs.ui.ac.id/peminjamanbuku/get-buku-by-id/$idBuku/",
      );
      List<Buku> listProduct = [];
      for (var d in response) {
          if (d != null) {
              listProduct.add(Buku.fromJson(d));
          }
      }
      return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    String dateString = DateFormat('dd/MM/yyyy').format(objek.fields.tanggalPengembalian);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengembalian Buku',
        ),
        foregroundColor: const Color.fromARGB(255, 42, 33, 0),
        backgroundColor: const Color(0xFFC9C5BA),
      ),
      backgroundColor: const Color.fromARGB(255, 242,238,227),
      body: FutureBuilder(
        future: fetchProduct(request), 
        builder: (BuildContext context, AsyncSnapshot<List<Buku>> snapshot) {  
          if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data produk.",
                    style:
                        TextStyle(color: Color.fromARGB(255, 42, 33, 0), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              DateTime currentDate = DateTime.now();
              DateTime returnDate = objek.fields.tanggalPengembalian;
              bool isReturnOverdue = currentDate.isAfter(returnDate);

              return ListView.builder(
                itemCount: 1,
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: Image.network(
                          snapshot.data![index].fields.img,
                          width: 200,
                          height: 250,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return SizedBox (
                              width: 200,
                              height: 250,
                              child : Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                                  color: Color(0xFFC9C5BA), // Set the desired background color
                                ),
                                child: const Icon(
                                  Icons.no_photography_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Nama peminjam: ${objek.fields.nama}"),
                      const SizedBox(height: 10),
                      Text("Tanggal Akhir Pengembalian: $dateString"),
                      const SizedBox(height: 10),
                      Text("Title : ${objek.fields.title}"),
                      const SizedBox(height: 10),
                      Text("Isbn : ${snapshot.data![index].fields.isbn}"),
                      const SizedBox(height: 10),
                      Text("Author : ${snapshot.data![index].fields.author}"),
                      const SizedBox(height: 10),
                      Text("Year : ${snapshot.data![index].fields.year}"),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFC9C5BA)),
                          foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 42, 33, 0)),
                        ), 
                        onPressed: () async {
                          final respons = await request.postJson(
                          "https://literahub-e08-tk.pbp.cs.ui.ac.id/peminjamanbuku/kembalikan-buku-flutter/$idBuku/",
                          jsonEncode(<String,int>{
                            'name': snapshot.data![index].pk,
                          }));
                        if (respons['status'] == 'success') {
                          if(isReturnOverdue){
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                              content: Text("Pengembalian buku terlambat!"),
                            ));
                          } else {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Buku ${snapshot.data![index].fields.title} berhasil dikembalikan"),
                            ));
                          }
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PeminjamanBukuPage()));
                          } else {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Terdapat kesalahan, silakan coba lagi."),
                            ));
                          }                  
                        }, 
                        child: const Text(
                          "Kembalikan"
                        ),
                      )
                    ],
                  ),
                )
              );
            }
          }
        },
      )
    );
  }
}