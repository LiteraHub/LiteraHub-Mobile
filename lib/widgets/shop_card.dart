// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:literahub/main.dart';
import 'package:literahub/screens/daftar_buku/cardDaftarBuku.dart';
import 'package:literahub/screens/forum/thread_forum.dart';
import 'package:literahub/screens/lembarasa/lembarasa_main.dart';
import 'package:literahub/screens/reservasi/reservasi_main.dart';
import 'package:literahub/screens/peminjamanbuku/peminjamanbuku_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ShopItem {
  final String name;
  final IconData icon;

  ShopItem(this.name, this.icon);
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: const Color(0xFFC9C5BA),
      child: InkWell(
        onTap: () async {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text("Kamu telah menekan tombol ${item.name}!"),
            ));
          if (item.name == "Logout") {
            final response = await request.logout(
              "https://literahub-e08-tk.pbp.cs.ui.ac.id/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$message Sampai jumpa, $uname."),
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            }
          } else if (item.name == "Forum") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ThreadPage()
              )
            );
          } else if (item.name == "Reservasi Tempat") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPageReservasi(),
              ),
            );
          } else if (item.name == "Daftar Buku") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CardDaftarBuku(),
                ));
          } else if (item.name == "Pinjam Buku") {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PeminjamanBukuPage()));
          } else if (item.name == "LembarAsa") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LembarAsaMain(),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 242, 238, 227),
                    boxShadow: [
                      BoxShadow(
                        color:  Color.fromARGB(255, 242, 238, 227),
                        blurRadius: 2.5,
                      ),
                    ],
                  ),
                  child: Icon(
                    item.icon,
                    color: const Color(0xFFC9C5BA),
                    size: 50.0,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 242, 238, 227),
                    fontSize: 23,
                    fontWeight: FontWeight.bold
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
