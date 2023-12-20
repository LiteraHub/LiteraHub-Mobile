import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import 'package:literahub/models/thread.dart';
import 'package:http/http.dart' as http;

class PostForm extends StatefulWidget {
  final Thread thread;
  final Key? key;

  PostForm({required this.thread, this.key}) : super(key: key);

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();
  String _body = "";
  int _thread = 0;
  String _date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final userProvider = context.watch<UserProvider>();

    _thread = widget.thread.pk;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: const Color(0xFFCBC6A3),
      title: Text("Buat Post"),
      content: SizedBox(
        height: 300,
        width: 600,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  maxLines: null,
                  maxLength: 1000,
                  decoration: InputDecoration(
                    hintText: "Isi Post",
                    labelText: "Isi Post",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _body = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Masukkan isi untuk post.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
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
        ElevatedButton( //TODO:Add post
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              /*try {
                final response = await request.postJson(
                  "http://localhost:8000/forum/add_post_flutter/",
                  jsonEncode(<String, dynamic>{
                    'body': _body,
                    'thread': _thread,
                    'date': _date,
                    'user': userProvider.username,
                  }),
                );

                // Check the status code of the response
                if (response.statusCode == 200) {
                  print('Server Response: ${response.body}');
                  Navigator.pop(context); // Close the dialog
                } else {
                  // Handle error cases
                  print('Error: ${response.body}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Failed to save. Please try again."),
                    ),
                  );
                }
              } finally {
                // Hide the loading indicator
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }*/
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
