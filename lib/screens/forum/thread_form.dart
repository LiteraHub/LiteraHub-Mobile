// ignore_for_file: library_prefixes, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:literahub/providers/user_provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:literahub/models/buku.dart' as modBuku;

class ThreadForm extends StatefulWidget {
  const ThreadForm({super.key});

  @override
  State<ThreadForm> createState() => _ThreadFormState();
}

class _ThreadFormState extends State<ThreadForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _buku = "";
  final String _date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  Future<List<String>> listTitle() async {
    var url = Uri.parse('https://literahub-e08-tk.pbp.cs.ui.ac.id/forum/json_buku/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // ambil title
    List<String> title_list = [];
    for (var d in data) {
      if (d != null) {
        title_list.add(modBuku.Buku.fromJson(d).fields.title);
      }
    }
    return title_list;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final userProvider = context.watch<UserProvider>();

    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      backgroundColor: const Color(0xFFCBC6A3),
      title: const Text('Tambah Thread'),
      content: SizedBox(
        height: 200.0,
        width: 1000.0,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Judul Thread",
                    labelText: "Judul Thread",
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
                      return "Masukkan judul untuk thread.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                FutureBuilder<List<String>>(
                  future: listTitle(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No data available');
                    } else {
                      return Container(
                          constraints: const BoxConstraints(
                            maxWidth: 980,
                          ),
                          height: 50.0, // Set a fixed height or adjust as needed
                          child: DropdownButtonFormField<String>(
                            value: null,
                            items: snapshot.data!.map((buku) {
                              return DropdownMenuItem<String>(
                                value: buku,
                                child: AutoSizeText(buku),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _buku = value ?? "-";
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Buku Diskusi?",
                              labelText: "Buku Diskusi?",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Use userProvider to get user information

                final response = await request.postJson(
                  "https://literahub-e08-tk.pbp.cs.ui.ac.id/forum/add_thread_flutter/",
                  jsonEncode(<String, dynamic>{
                    'name': _name,
                    'buku': _buku,
                    'date': _date,
                    'user': userProvider.username,
                  }),
                );
                Navigator.pop(context); // Close the dialog
              }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}