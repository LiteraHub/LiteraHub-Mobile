import 'package:flutter/material.dart';
import 'package:literahub/models/buku.dart';

class BukuTersediaPage extends StatefulWidget {
  final Buku objekPinjam;
  const BukuTersediaPage(this.objekPinjam, {Key? key}) : super(key: key);

  
  @override
  // ignore: no_logic_in_create_state
  State<BukuTersediaPage> createState() => _BukuTersediaPageState(objekPinjam);
}

class _BukuTersediaPageState extends State<BukuTersediaPage>{
  final Buku objek;
  _BukuTersediaPageState(this.objek);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengembalian Buku',
        ),
        foregroundColor: const Color.fromARGB(255, 42, 33, 0),
        backgroundColor: const Color(0xFFC9C5BA),
      ),
      backgroundColor: const Color.fromARGB(255, 242,238,227),
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
              errorBuilder: (context, error, stackTrace) {
                return SizedBox (
                  width: 200,
                  height: 250,
                  child : Container(
                    alignment: Alignment.center,
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
        ),
        const SizedBox(height: 20),
        Text("Title : ${objek.fields.title}", 
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 42, 33, 0),
          fontSize: 15,
        ),
        ),
        const SizedBox(height: 10),
        Text("Isbn : ${objek.fields.isbn}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 42, 33, 0),
          fontSize: 15,
        ), 
        textAlign: TextAlign.center
        ),
        const SizedBox(height: 10),
        Text("Author : ${objek.fields.author}", 
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 42, 33, 0),
          fontSize: 15,
        ), 
        textAlign: TextAlign.center
        ),
        const SizedBox(height: 10),
        Text("Year : ${objek.fields.year}", 
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 42, 33, 0),
          fontSize: 15,
        ),        
        textAlign: TextAlign.center
        ),
        const SizedBox(height: 10),
      ],
    ),
    );
  }
}