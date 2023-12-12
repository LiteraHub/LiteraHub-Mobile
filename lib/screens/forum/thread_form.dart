import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:literahub/models/thread.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ThreadForm extends StatefulWidget {
  const ThreadForm({super.key});

  @override
  State<ThreadForm> createState() => _ThreadFormState();
}

class _ThreadFormState extends State<ItemFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _user = "";
  String _name = "";
  String _book = "";
  String _date = "";
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Add Thread',
            ),
          ),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        drawer: const LeftDrawer(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Thread Title",
                        labelText: "Thread Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _name = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a title for the thread.";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Related Book",
                        labelText: "Related Book (not mandatory)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _buku = value!;
                        });
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
                          MaterialStateProperty.all(Colors.indigo),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('The item has been saved.'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('Title: $_name'),
                                        Text('Book: $_buku'),
                                        Text('Date: ' + new DateTime.now()),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          // Kirim ke Django dan tunggu respons
                                          final response = await request.postJson(
                                              "https://literahub-e08-tk.pbp.cs.ui.ac.id/add_thread_flutter/",
                                              jsonEncode(<String, String>{
                                                'name': _name,
                                                'buku': _buku,
                                                'date': new DateTime.now(),
                                              }));
                                          if (response['status'] == 'success') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text("Thread has been created"),
                                            ));
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => MyHomePage()),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content:
                                              Text("Terdapat kesalahan, silakan coba lagi."),
                                            ));
                                          }
                                        }
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
                ]
            ),
          ),
        ));
  }
}