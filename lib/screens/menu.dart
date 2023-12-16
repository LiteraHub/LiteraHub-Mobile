import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:literahub/widgets/shop_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final List<ShopItem> items = [
    ShopItem("LembarAsa", Icons.mode_edit_outline_outlined),
    ShopItem("Pinjam Buku", Icons.bookmark_add_rounded),
    ShopItem("Daftar Buku", Icons.menu_book_rounded),
    ShopItem("Reservasi Tempat", Icons.chair_alt_rounded),
    ShopItem("Forum", Icons.format_list_bulleted_rounded),
    ShopItem("Logout", Icons.logout_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LiteraHub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.black87,
      ),
      drawer: const LeftDrawer(),
      backgroundColor: const Color.fromARGB(255, 255, 254, 249),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 254, 249),
              Color.fromARGB(255, 242, 238, 227),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Selamat datang di',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'LiteraHub',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                      shadows: [
                        BoxShadow(
                          color: const Color(0xFFC9C5BA).withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 7.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    '"Halaman demi halaman, kita membangun jalan di tengah hutan kata-kata yang lebat. Setiap langkah membawa kita lebih dekat pada kebijaksanaan dan pemahaman yang menghiasi lorong literasi."',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 60.0,),
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1.7,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    viewportFraction: 0.6,
                  ),
                  items: items.map((ShopItem item) {
                    return Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ShopCard(item),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 100.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
