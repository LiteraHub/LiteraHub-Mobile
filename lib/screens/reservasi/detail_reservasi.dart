import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:literahub/models/reservasi_model.dart';

class DetailPage extends StatelessWidget {
  final Reservasi reservasi;

  const DetailPage({Key? key, required this.reservasi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Reservasi',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        foregroundColor: const Color.fromARGB(255, 42, 33, 0),
        backgroundColor: const Color(0xFFC9C5BA),
      ),
      backgroundColor: const Color.fromARGB(255, 242,238,227),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat('dd/MM/yyyy').format(reservasi.fields.tanggal),
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'ID Buku   : ${reservasi.fields.buku}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'ID Tempat : ${reservasi.fields.tempatBaca}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Pukul     : ${reservasi.fields.jam}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Durasi    : ${reservasi.fields.durasiBaca} jam',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
