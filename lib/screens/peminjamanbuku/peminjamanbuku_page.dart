
import 'package:flutter/material.dart';
import 'package:literahub/screens/peminjamanbuku/book_tersedia.dart';
import 'package:literahub/screens/peminjamanbuku/pengembalian_buku.dart';
import 'package:literahub/screens/peminjamanbuku/services/filter.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:literahub/screens/peminjamanbuku/form_peminjaman.dart';

class PeminjamanBukuPage extends StatefulWidget {
  PeminjamanBukuPage({Key? key}) : super(key: key);
  
  @override
  _PeminjamanBukuPageState createState() => _PeminjamanBukuPageState();
}

class _PeminjamanBukuPageState extends State<PeminjamanBukuPage> {
  var search;
  Filter _filtered = Filter(); 

  void updateSearch(String value){
    String searchTerm = value.trim().toLowerCase();
    setState(() {
      if(search != ""){
        search = searchTerm;
      }
      else{
        search = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Peminjaman Buku',
        ),
        foregroundColor: const Color.fromARGB(255, 42, 33, 0),
        backgroundColor: const Color(0xFFC9C5BA),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Peminjaman Buku',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Ingin Meminjam Buku? Tekan Tombol dibawah ini!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PeminjamanForm()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFC9C5BA)),
                  foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 42, 33, 0)),
                ),
                child: const Text('Pinjam Buku')
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReturnBookPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFC9C5BA)),
                  foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 42, 33, 0)),
                ),
                child: const Text('Kembalikan Buku')
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Buku Tersedia',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Membulatkan sudut
                  border: Border.all(
                    color: Color.fromARGB(255, 42, 33, 0),
                    width: 2.0,
                  ),
                ),
                child: TextFormField(
                  onChanged: (value) => updateSearch(value),
                  decoration: const InputDecoration(
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 40, // Atur lebar minimum untuk ikon pencarian
                      minHeight: 40, // Atur tinggi minimum untuk ikon pencarian
                    ),
                    contentPadding: EdgeInsets.fromLTRB(16.0, 9.0, 16.0, 8.0),
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: "Search judul...",
                  ),
                ),
              ),
              FutureBuilder(
                  future: _filtered.getFiltered(query: search),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                          child: CircularProgressIndicator());
                    } else {
                      if (!snapshot.hasData) {
                        return const Column(
                          children: [
                            Text(
                              "Tidak ada data produk.",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 42, 33, 0), fontSize: 20),
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
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute( builder: (context) => BukuTersediaPage(snapshot.data![index]),
                                  )
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                  decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                        const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                                      child: AspectRatio(
                                        aspectRatio: 2/3,
                                        child: Image.network(
                                        '${snapshot.data![index].fields.img}',
                                        width: 200,
                                        height: 250,
                                        fit: BoxFit.fill,
                                        ),
                                      )   
                                    ),
                                    Expanded(
                                      child: Container(
                                      padding: EdgeInsets.all(20),
                                        child: Align( 
                                          alignment: Alignment.center,
                                          child: RichText(
                                            overflow: TextOverflow .ellipsis,
                                            maxLines: 2,
                                            strutStyle: 
                                            StrutStyle( fontSize: 10.0),
                                            text: TextSpan(
                                              style: const TextStyle(
                                                color:Color.fromARGB(255, 42, 33, 0),
                                                fontSize: 17,
                                              ),
                                              text: '${snapshot.data![index].fields.title}',
                                            ),
                                          ),
                                        ),
                                      ), 
                                    ),
                                  ]
                                )
                              )
                            ),
                          )
                        );
                      }
                    }
                  }
                )
            ],
          ),
        ),
      ),
    );
  }
}

