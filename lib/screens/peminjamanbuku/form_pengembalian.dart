import 'package:flutter/material.dart';
import 'package:literahub/widgets/left_drawer.dart';

class PengembalianForm extends StatefulWidget {
  const PengembalianForm({Key? key}) : super(key: key);

  @override
  State<PengembalianForm> createState() => _PengembalianFormState();
}

class _PengembalianFormState extends State<PengembalianForm>{
  final _formKey = GlobalKey<FormState>();
  String _judulBuku = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Pengembalian Buku',
          ),
        ),
              backgroundColor: const Color(0xFFC9C5BA),
        foregroundColor: Colors.black,
      ),
      drawer: const LeftDrawer(),
    );
  }
}