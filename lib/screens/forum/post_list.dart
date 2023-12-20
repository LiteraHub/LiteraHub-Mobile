// ignore_for_file: overridden_fields, annotate_overrides, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:literahub/models/post.dart';
import 'package:literahub/models/thread.dart';
import 'package:literahub/screens/forum/post_form.dart';
import 'package:literahub/widgets/left_drawer.dart';

class PostPage extends StatefulWidget {
  final Thread thread;
  final Key? key;

  const PostPage({required this.thread, this.key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> { //get posts filtered by thread
  Future<List<Post>> fetchPosts() async {
    var url = Uri.parse('http://127.0.0.1:8000/forum/json_posts/${widget.thread.pk}/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Post> listPost = [];
    for (var d in data) {
      if (d != null) {
        listPost.add(Post.fromJson(d));
      }
    }
    return listPost;
  }

  Future<String> fetchUsername(int userId) async { //get usernames
    var url = Uri.parse('http://127.0.0.1:8000/usernames/$userId/');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    return data['username'];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.thread.fields.name),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data post.",
                    style:
                    TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => FutureBuilder<String>(
                  future: fetchUsername(snapshot.data![index].fields.user),
                  builder: (context, usernameSnapshot) {
                    if (usernameSnapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // or any loading indicator
                    } else if (usernameSnapshot.hasError) {
                      return const Text('Error fetching username');
                    } else {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(usernameSnapshot.data ?? 'User tidak diketahui'),
                            Text(
                              "${snapshot.data![index].fields.body}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.date}"),
                          ],
                        ),
                      );
                    }
                  },
                ),
              );
            }
          }
        },
      ),
        floatingActionButton: FloatingActionButton.extended( //add post button
          label: const Text('+ Post'),
          backgroundColor: const Color(0x001b1d39),
          foregroundColor: Colors.white,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PostForm(thread: widget.thread);
              },
            );
          },
        )
    );
  }
}