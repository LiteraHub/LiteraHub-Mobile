// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:literahub/models/reservasi_model.dart';
import 'package:literahub/screens/reservasi/detail_reservasi.dart';
import 'package:literahub/screens/reservasi/reservasi_main.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class HistoriReservasiPage extends StatefulWidget {
  const HistoriReservasiPage({Key? key}) : super(key: key);

  @override
  _HistoriReservasiPageState createState() => _HistoriReservasiPageState();
}

class _HistoriReservasiPageState extends State<HistoriReservasiPage> {
  bool isButtonActive = true;
  

  Future<List<Reservasi>> fetchReservasi(CookieRequest request) async {
    var mapJsonData = request.jsonData;
    var username = mapJsonData['username'];

    var url =
      "https://literahub-e08-tk.pbp.cs.ui.ac.id/reservasi/get-reservasi-flutter/";
      // "http://localhost:8000/reservasi/get-reservasi-flutter/";
    final response = await request.postJson(
      url,
      jsonEncode(<String, String>{
        'user': username
      }));
        
    // melakukan konversi data json menjadi object Reservasi
    List<Reservasi> listReservasi = [];
    for (var d in response) {
      if (d != null) {
        listReservasi.add(Reservasi.fromJson(d));
      }
    }
    return listReservasi;
  }

  String formatTanggal(DateTime tanggal) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(tanggal);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    var mapJsonData = request.jsonData;
    var username = mapJsonData['username'];
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 242, 238, 227),
        appBar: AppBar(
          title: const Text(
            'Histori Reservasi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: const Color.fromARGB(255, 42, 33, 0),
          backgroundColor: const Color(0xFFC9C5BA),
        ),
        body: FutureBuilder(
          future: Future.wait([fetchReservasi(request)]),
          builder: (context, AsyncSnapshot<List<dynamic>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Terjadi kesalahan: ${snapshot.error}"),
              );
            } else {
              List<Reservasi> myReservasi = snapshot.data![0];
              if (myReservasi.isEmpty) {
                return const Center(
                    child: Text(
                      'Belum ada reservasi.\nAyo reservasi dan membaca bersama di LiteraHub!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      ));
              } else {
                return ListView.builder(
                  itemCount: myReservasi.length,
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(reservasi: myReservasi[index]),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Container(
                        color: const Color.fromARGB(255, 223, 180, 120),
                        padding: const EdgeInsets.all(16.0),
                        child:
                          Column(mainAxisSize: MainAxisSize.min, 
                          children: [
                          Center(
                            child: Text(
                              formatTanggal(myReservasi[index].fields.tanggal),
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          myReservasi[index].fields.selesai ? const SizedBox() : ElevatedButton(
                            onPressed: isButtonActive ? () async {
                              // Aksi ketika tombol ditekan
                              var url =
                                  "https://literahub-e08-tk.pbp.cs.ui.ac.id/reservasi/selesai-flutter/";
                                  // "http://localhost:8000/reservasi/selesai-flutter/";
                              final response = await request.postJson(
                                  url,
                                  jsonEncode(<String, String>{
                                    'reservasi_id':
                                        myReservasi[index].pk.toString(),
                                    'user': username
                                  }));
                              setState(() {
                                myReservasi[index].fields.selesai = true;
                                isButtonActive = false;
                              });
                              if (response['status'] == 'success') {
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainPageReservasi()),
                                );
                              }
                            } : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Selesai'),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            myReservasi[index].fields.selesai 
                              ? "Reservasi Anda selesai\nKlik untuk melihat detail" 
                              : "Tekan tombol saat Anda telah selesai\nKlik untuk melihat detail",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                );
              }
            }
          },
        ));
  }
}
