import 'package:flutter/material.dart';
import 'package:literahub/screens/peminjamanbuku/return_book.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:literahub/screens/peminjamanbuku/form_peminjaman.dart';

class PeminjamanBukuPage extends StatelessWidget {
  PeminjamanBukuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Peminjaman Buku',
        ),
        backgroundColor: const Color(0xFFC9C5BA),
        foregroundColor: Colors.black,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Peminjaman Buku',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Ingin Meminjam Buku? Tekan Tombol dibawah ini!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PeminjamanForm()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFC9C5BA)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: const Text('Pinjam Buku')
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReturnBookPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFC9C5BA)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: const Text('Kembalikan Buku')
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Buku Dipinjam',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // TODO: Tambahkan widget untuk menampilkan buku yang dipinjam di sini
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Buku Tersedia',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // TODO: Tambahkan widget untuk menampilkan buku yang tersedia di sini
            ],
          ),
        ),
      ),
    );
  }
}
