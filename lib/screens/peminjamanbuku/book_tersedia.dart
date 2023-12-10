import 'package:flutter/material.dart';
import 'package:literahub/models/buku.dart';

class BukuTersediaPage extends StatefulWidget {
  final Buku objekPinjam;
  const BukuTersediaPage(this.objekPinjam, {Key? key}) : super(key: key);

  
  @override
  _BukuTersediaPageState createState() => _BukuTersediaPageState(objekPinjam);
}

class _BukuTersediaPageState extends State<BukuTersediaPage>{
  final Buku objek;
  _BukuTersediaPageState(this.objek);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Detail Buku',
          ),
        ),
        backgroundColor: const Color(0xFFC9C5BA),
        foregroundColor: Colors.black,
      ),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center, // Menengahkan secara horizontal
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            child: Image.network(
              objek.fields.img,
              width: 200,
              height: 250,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text("Title : ${objek.fields.title}", textAlign: TextAlign.center),
        const SizedBox(height: 10),
        Text("Isbn : ${objek.fields.isbn}", textAlign: TextAlign.center),
        const SizedBox(height: 10),
        Text("Author : ${objek.fields.author}", textAlign: TextAlign.center),
        const SizedBox(height: 10),
        Text("Year : ${objek.fields.year}", textAlign: TextAlign.center),
        const SizedBox(height: 10),
      ],
    ),
    );
  }
}