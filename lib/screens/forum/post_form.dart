import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import 'package:literahub/models/thread.dart';

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
      title: Text("+ Post"),
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
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // Use userProvider to get user information
              final response = await request.postJson(
                "http://127.0.0.1:8000/forum/add_post_flutter/$_thread/",
                jsonEncode(<String, dynamic>{
                  'body': _body,
                  'thread': _thread,
                  'date': _date,
                  'user': userProvider.username,
                }),
              );

              print('Server Response: ${response.body}');
              Navigator.pop(context); // Close the dialog
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}