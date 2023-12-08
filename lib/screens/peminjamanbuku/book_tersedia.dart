import 'package:flutter/material.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BukuTersediaPage extends StatefulWidget {
  const BukuTersediaPage({super.key});
  
  @override
  _BukuTersediaPageState createState() => _BukuTersediaPageState();
}

class _BukuTersediaPageState extends State<BukuTersediaPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'List Buku Ready Dipinjam',
          ),
        ),
        backgroundColor: const Color(0xFFC9C5BA),
        foregroundColor: Colors.black,
      ),
      drawer: const LeftDrawer(),
      // TODO: Buat future builder buat ngeloop semua buku yang bisa sedang dipinjam
    );
  }
}