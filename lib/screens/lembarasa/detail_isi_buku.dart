import 'package:flutter/material.dart';
import 'package:literahub/models/buku.dart';
import 'package:literahub/models/mybuku.dart';

class DetailBuku extends StatelessWidget {
  final Buku buku;
  final MyBuku myBuku;

  const DetailBuku({Key? key, required this.buku, required this.myBuku}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          buku.fields.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFC9C5BA),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  buku.fields.title,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'oleh : ${buku.fields.author}',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    myBuku.fields.isi, 
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
