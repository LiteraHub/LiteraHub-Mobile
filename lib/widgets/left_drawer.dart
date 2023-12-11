import 'package:flutter/material.dart';
import 'package:literahub/screens/menu.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});
  static const IconData format_list_bulleted = IconData(0xe2b8, fontFamily: 'MaterialIcons', matchTextDirection: true);

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
            // onTap: () {
            //   // Routing ke InventoriFormPage,
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const ProductPage(),
            //       ));
            // },
          ),
          ListTile(
            leading: const Icon(Icons.format_list_bulleted),
            title: const Text('Pinjam Buku'),
            // Bagian redirection ke Pinjam Buku
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
            leading: const Icon(Icons.format_list_bulleted),
            title: const Text('Daftar Buku'),
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
            leading: const Icon(Icons.format_list_bulleted),
            title: const Text('Reservasi Tempat'),
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
            leading: const Icon(Icons.format_list_bulleted),
            title: const Text('Forum'),
            // Bagian redirection ke Forum
            // onTap: () {
            //   // Routing ke InventoriFormPage,
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => ThreadPage(),
            //       ));
            // },
          ),
          ListTile(
            leading: const Icon(Icons.format_list_bulleted),
            title: const Text('Logout'),
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
