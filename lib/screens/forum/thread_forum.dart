import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:literahub/models/thread.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ThreadPage extends StatefulWidget {
  @override
  _ThreadPageState createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  Future<List<Thread>> fetchThread() async {
    var url = Uri.parse(
        'https://literahub-e08-tk.pbp.cs.ui.ac.id//forum/json_thread/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Thread> list_thread = [];
    for (var d in data) {
      if (d != null) {
        list_thread.add(Thread.fromJson(d));
      }
    }
    return list_thread;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Threads'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchThread(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data thread.",
                        style:
                        TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) =>
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.name}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.buku}"),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.date}"),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ));
                }
              }
            }));
  }
}