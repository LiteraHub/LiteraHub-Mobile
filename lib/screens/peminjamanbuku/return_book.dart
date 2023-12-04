import 'package:flutter/material.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReturnBookPage extends StatefulWidget {
  const ReturnBookPage({super.key});
  
  @override
  _ReturnBookPageState createState() => _ReturnBookPageState();
}

class _ReturnBookPageState extends State<ReturnBookPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'List Buku Dipinjam',
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