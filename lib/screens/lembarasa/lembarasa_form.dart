import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:literahub/screens/lembarasa/lembarasa_main.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LembarAsaFormPage extends StatefulWidget {
  const LembarAsaFormPage({super.key});

  @override
  State<LembarAsaFormPage> createState() => _LembarAsaFormPageState();
}

class _LembarAsaFormPageState extends State<LembarAsaFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _img = "";
  String _isi = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      appBar: AppBar (
        title: const Text(
          'Form Tambah Item',
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFC9C5BA),
      ),
      // drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height : 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Judul Buku",
                    labelText: "Judul Buku",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  maxLength: 50,
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Judul buku tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Tautan Gambar",
                    labelText: "Tautan Gambar",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _img = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Tautan gambar tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Isi Buku",
                    labelText: "Isi Buku",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _isi = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Isi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Kirim ke Django dan tunggu respons
                        final response = await request.postJson(
                          "http://127.0.0.1:8000/lembar-asa/create-flutter/",
                          jsonEncode(<String, String>{
                            'title': _title,
                            'img': _img,
                            'isi': _isi,
                        }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                              content: Text("Buku baru berhasil disimpan!"),
                          ));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LembarAsaMain()),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            content:
                              Text("Terdapat kesalahan, silakan coba lagi."),
                            )
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ]
          )
        ),
      ),
    );
  }
}

