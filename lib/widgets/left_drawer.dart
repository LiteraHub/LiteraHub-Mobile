import 'package:flutter/material.dart';
import 'package:literahub/main.dart';
import 'package:literahub/screens/daftar_buku/cardDaftarBuku.dart';
import 'package:literahub/screens/forum/thread_forum.dart';
import 'package:literahub/screens/lembarasa/lembarasa_main.dart';
import 'package:literahub/screens/menu.dart';
import 'package:literahub/screens/reservasi/reservasi_main.dart';
import 'package:literahub/screens/peminjamanbuku/peminjamanbuku_page.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: const Color(0xFFC9C5BA),
            padding: const EdgeInsets.all(20),
            child: const Column(
              children: [
                Text(
                  'LiteraHub Menu',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Baca buku dengan mudah melalui LiteraHub!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: const Icon(Icons.home_outlined, color: Colors.black54, size: 30),
            title: const Text('Halaman Utama', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: const Icon(Icons.mode_edit_outline_rounded, color: Colors.black54, size: 30),
            title: const Text('LembarAsa', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LembarAsaMain(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: const Icon(Icons.bookmark_add_rounded, color: Colors.black54, size: 30),
            title: const Text('Pinjam Buku', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PeminjamanBukuPage(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: const Icon(Icons.menu_book_rounded, color: Colors.black54, size: 30),
            title: const Text('Daftar Buku', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CardDaftarBuku(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: const Icon(Icons.chair_alt_rounded, color: Colors.black54, size: 30),
            title: const Text('Reservasi Tempat', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPageReservasi(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: const Icon(Icons.format_list_bulleted_rounded, color: Colors.black54, size: 30),
            title: const Text('Forum', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThreadPage(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: const Icon(Icons.logout_rounded, color: Colors.black54, size: 30),
            title: const Text('Logout', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
