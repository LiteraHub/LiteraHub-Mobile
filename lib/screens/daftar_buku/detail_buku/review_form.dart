import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewFormPage extends StatefulWidget {
  final int id;
  const ReviewFormPage(this.id, {Key? key}) : super(key: key);

  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState(id);
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  final int id;
  _ReviewFormPageState(this.id);

  final _formKey = GlobalKey<FormState>();
  String _review = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Form Tambah Review',
            ),
          ),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Review",
                    labelText: "Review",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _review = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Tada! Nampaknya kamu lupa memberikan sentuhan review-nya, yuk disegerakan!";
                    } else if (value.length > 45) {
                      return "Review tidak boleh lebih dari 45 huruf yaa";
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
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Kirim ke Django dan tunggu respons
                        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                        final response = await request.postJson(
                            "https://literahub-e08-tk.pbp.cs.ui.ac.id/daftarbuku/add_review_flutter/",
                            jsonEncode(<String, String>{
                              'review': _review,
                              'book_id': id.toString(),
                            }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Review Anda berhasil disimpan!"),
                          ));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("Terdapat kesalahan, silakan coba lagi."),
                          ));
                        }
                        //Memasukkan hasil inputan ke dalam model item
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Item berhasil tersimpan'),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        _formKey.currentState!.reset();
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
