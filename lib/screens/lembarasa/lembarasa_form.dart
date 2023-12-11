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
          'Tambah Karya',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFC9C5BA),
        foregroundColor: Colors.black87,
      ),
      backgroundColor: const Color.fromARGB(255, 242, 238, 227),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height : 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black54,
                    decoration: InputDecoration(
                      hintText: "Judul Buku",
                      labelText: "Judul Buku",
                      labelStyle: const TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.black54), 
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
                    cursorColor: Colors.black54,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Tautan Gambar",
                      labelText: "Tautan Gambar",
                      labelStyle: const TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.black54), 
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
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black54,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Isi Buku",
                      labelText: "Isi Buku",
                      labelStyle: const TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.black54), 
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC9C5BA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        minimumSize: const Size(225.0, 50.0),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
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
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            )
          ),
        ),
      ),
    );
  }
}

