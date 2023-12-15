import 'package:flutter/material.dart';
import 'package:literahub/screens/daftar_buku/bookinfopage.dart';
import 'package:literahub/models/buku.dart';

class DaftarBukuPage extends StatelessWidget {
  final Buku item;

  const DaftarBukuPage(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        // color: Colors.brown.shade50,
        child: InkWell(
            onTap: () {
              // Memunculkan SnackBar ketika diklik
              // Navigate ke route yang sesuai (tergantung jenis tombol)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookInfoPage(item.pk),
                  ));
            },
            child: Container(
              // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: const BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                color: Colors.deepOrange,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black26,
                //     spreadRadius: 1,
                //     blurRadius: 6,
                //   ),
                // ],
              ),
              // padding: const EdgeInsets.all(8),
              child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.visibility_off,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    const Padding(padding: EdgeInsets.all(3)),
                    Text(
                      item.fields.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            )));
  }
}
