import 'package:flutter/material.dart';
import 'package:literahub/screens/reservasi/list_reservasi.dart';
import 'package:literahub/screens/reservasi/reservasi_form.dart';

class MainPageReservasi extends StatelessWidget {
  const MainPageReservasi({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservasi LiteraHub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: const Color.fromARGB(255, 42, 33, 0),
        backgroundColor: const Color(0xFFC9C5BA),
      ),
      backgroundColor: const Color.fromARGB(255, 242,238,227),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Kamu Ingin Membaca Bersama di LiteraHub?',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Ayo segera reservasi tempat bacamu!',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman form reservasi
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReservasiFormPage(),
                  )
                );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                ),
                child: const Text('Reservasi Disini'),
              ),
              const SizedBox(height: 20.0), // Spasi antara dua tombol

              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman form reservasi
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoriReservasiPage(),
                  )
                );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                ),
                child: const Text('Lihat Reservasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
