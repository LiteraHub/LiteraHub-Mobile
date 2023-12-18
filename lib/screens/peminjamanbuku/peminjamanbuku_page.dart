import 'package:flutter/material.dart';
import 'package:literahub/widgets/left_drawer.dart';

class PeminjamanBukuPage extends StatefulWidget {
  const PeminjamanBukuPage({Key? key}) : super(key: key);

  @override
  State<PeminjamanBukuPage> createState() => _PeminjamanBukuPageState();
}

class _PeminjamanBukuPageState extends State<PeminjamanBukuPage> {
  String? search;
  final Filter _filtered = Filter();

  void updateSearch(String value) {
    String searchTerm = value.trim().toLowerCase();
    setState(() {
      search = searchTerm.isNotEmpty ? searchTerm : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peminjaman Buku',
          style: TextStyle(
          fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFC9C5BA),
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color.fromARGB(255, 242, 238, 227),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            const Text(
              'Peminjaman Buku',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingin Meminjam Buku? Tekan Tombol dibawah ini!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PeminjamanForm()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              ),
              child: const Text('Pinjam Buku'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReturnBookPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              ),
              child: const Text('Kembalikan Buku'),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 5),
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color.fromARGB(255, 42, 33, 0),
                  width: 2.0,
                ),
              ),
              child: TextFormField(
                onChanged: (value) => updateSearch(value),
                decoration: const InputDecoration(
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: "Search judul...",
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Buku Tersedia',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: _filtered.getFiltered(query: search),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData || snapshot.data!.length == 0) {
                    return const Column(
                      children: [
                        SizedBox(height: 75),
                        Text(
                          "Tidak ada buku yang tersedia.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 42, 33, 0),
                            fontSize: 19,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5,
                        mainAxisSpacing: 8,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BukuTersediaPage(snapshot.data![index]),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 2 / 3,
                                  child: Image.network(
                                    '${snapshot.data![index].fields.img}',
                                    width: 200,
                                    height: 250,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return SizedBox(
                                        width: 200,
                                        height: 250,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            ),
                                            color: Color(0xFFC9C5BA),
                                          ),
                                          child: const Icon(
                                            Icons.no_photography_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      strutStyle: const StrutStyle(fontSize: 10.0),
                                      text: TextSpan(
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                        text: '${snapshot.data![index].fields.title}',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
