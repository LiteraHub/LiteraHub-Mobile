import 'package:flutter/material.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:literahub/widgets/shop_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final List<ShopItem> items = [
    ShopItem("LembarAsa", Icons.add_shopping_cart),
    ShopItem("Pinjam Buku", Icons.checklist),
    ShopItem("Daftar Buku", Icons.add_shopping_cart),
    ShopItem("Reservasi Tempat", Icons.add_shopping_cart),
    ShopItem("Forum", Icons.add_shopping_cart),
    ShopItem("Logout", Icons.logout),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LiteraHub',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.black87,
      ),
      drawer: const LeftDrawer(),
      backgroundColor: const Color.fromARGB(255, 242, 238, 227),

      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Welcome', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item) {
                  // Iterasi untuk setiap item
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
