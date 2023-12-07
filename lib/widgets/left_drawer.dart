import 'package:flutter/material.dart';
import 'package:literahub/screens/lembarasa/lembarasa_main.dart';
import 'package:literahub/screens/menu.dart';
import 'package:literahub/screens/peminjamanbuku/peminjamanbuku_page.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Column(
                children: [
                  Text(
                    'LiteraHub menu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    "Baca buku dengan mudah melalui LiteraHub!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal, // Weight biasa
                    ),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: const Text('LembarAsa'),
            // Bagian redirection ke LembarAsa
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LembarAsaMain(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Pinjam Buku'),
            // Bagian redirection ke Pinjam Buku
            onTap: () {
              // Routing ke InventoriFormPage,
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PeminjamanBukuPage(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text('Daftar Buku'),
            // Bagian redirection ke Daftar Buku
            // onTap: () {
            //   // Routing ke InventoriFormPage,
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => InventoriFormPage(),
            //       ));
            // },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text('Reservasi Tempat'),
            // Bagian redirection ke Reservasi Tempat
            // onTap: () {
            //   // Routing ke InventoriFormPage,
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => InventoriFormPage(),
            //       ));
            // },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text('Forum'),
            // Bagian redirection ke Forum
            // onTap: () {
            //   // Routing ke InventoriFormPage,
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => InventoriFormPage(),
            //       ));
            // },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text('Logout'),
            // Bagian redirection ke Logout
            // onTap: () {
            //   // Routing ke InventoriFormPage,
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => InventoriFormPage(),
            //       ));
            // },
          ),
        ],
      ),
    );
  }
}
