import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:literahub/models/thread.dart';
import 'package:literahub/screens/forum/thread_forum.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:literahub/providers/user_provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ThreadForm extends StatefulWidget {
  const ThreadForm({super.key});

  @override
  State<ThreadForm> createState() => _ThreadFormState();
}

class _ThreadFormState extends State<ThreadForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  dynamic _buku;
  String _date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  Future<Map<String, dynamic>> getBukuByTitle(String title) async {
    final response =
    await http.get(Uri.parse('http://127.0.0.1:8000/forum/buku_title/$title/'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load book');
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final userProvider = context.watch<UserProvider>();

    return AlertDialog(
      title: const Text('Add Thread'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
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
              SizedBox(height: 16.0),
              TextFormField(
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
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // Use userProvider to get user information
              final response =
                  await request.postJson(
                "http://127.0.0.1:8000/forum/add_thread_flutter/",
                jsonEncode(<String, String>{
                  'name': _name,
                  'buku': _buku,
                  'date': _date,
                  'user': userProvider.username ?? '',
                }),
              );
              Navigator.pop(context); // Close the dialog
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}