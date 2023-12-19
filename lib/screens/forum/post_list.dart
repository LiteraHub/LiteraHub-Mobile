import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:literahub/models/post.dart';
import 'package:literahub/models/thread.dart';
import 'package:literahub/screens/forum/post_form.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class PostPage extends StatefulWidget {
  final Thread thread;
  final Key? key;

  PostPage({required this.thread, this.key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
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

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.thread.fields.name}'),
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
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height:10),
                      Text("${snapshot.data![index].fields.user}"), //how do I make this show the username
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
                ),
              );
            }
          }
        },
      ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('+ Post'),
          backgroundColor: const Color(0x1B1D39),
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
