import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:literahub/models/thread.dart';
import 'package:literahub/models/buku.dart' as modBuku;
import 'package:literahub/widgets/left_drawer.dart';
import 'package:literahub/screens/forum/thread_form.dart';

class ThreadPage extends StatefulWidget {
  @override
  _ThreadPageState createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  Future<List<Thread>> fetchThread() async {
    var url = Uri.parse('http://127.0.0.1:8000/forum/json_thread/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Thread> listThread = [];
    for (var d in data) {
      if (d != null) {
        listThread.add(Thread.fromJson(d));
      }
    }
    return listThread;
  }

  Future<modBuku.Buku?> fetchBuku(int? bukuId) async {
    if (bukuId == null) { //default buku
      return modBuku.Buku(
        model: modBuku.Model.BUKU_BUKU,
        pk: 0,
        fields: modBuku.Fields(
          isbn: 'default_isbn',
          title: 'Default Title',
          author: 'Default Author',
          year: 2000,
          img: 'default_image.jpg',
          isReady: false,
        ),
      );
    }
    var url = Uri.parse('http://127.0.0.1:8000/forum/buku_id/$bukuId/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return modBuku.Buku.fromJson(data);
    } else {
      return null;
    }
  }

  Widget buildBookCard(Thread thread, modBuku.Buku? buku) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${thread.fields.name}",
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // If no book cover, display only the container
            Container(
              width: 100,
              height: 150,
              child: buku != null
                  ? Image.network(
                buku.fields.img,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
              )
                  : Container(
                color: Colors.grey, // placeholder if pictures don't work
              ),
            ),
            const SizedBox(height: 10),
            Text("${thread.fields.date}"),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FORUM'),
        backgroundColor: const Color(0xFFC9C5BA),
        foregroundColor: Colors.black,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Thread>>(
        future: fetchThread(),
        builder: (context, AsyncSnapshot<List<Thread>> threadSnapshot) {
          if (threadSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (threadSnapshot.hasError) {
            return Center(child: Text("Error: ${threadSnapshot.error}"));
          } else if (!threadSnapshot.hasData || threadSnapshot.data!.isEmpty) {
            return Column(
              children: [
                Text(
                  "Tidak ada data thread.",
                  style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                ),
                SizedBox(height: 8),
              ],
            );
          } else {
            return ListView.builder(
              itemCount: threadSnapshot.data!.length,
              itemBuilder: (_, index) => FutureBuilder<modBuku.Buku?>(
                future: fetchBuku(threadSnapshot.data![index].fields.buku),
                builder: (context, AsyncSnapshot<modBuku.Buku?> bukuSnapshot) {
                  if (bukuSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (bukuSnapshot.hasError) {
                    return Text("Error: ${bukuSnapshot.error}");
                  } else {
                    final buku = bukuSnapshot.data;
                    return buildBookCard(threadSnapshot.data![index], buku);
                  }
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('+ Thread'),
        backgroundColor: Color(0x1B1D39),
        foregroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ThreadForm();
            },
          );
        },
      ),
    );
  }
}