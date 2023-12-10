import 'package:flutter/material.dart';
import 'package:literahub/screens/peminjamanbuku/book_detail.dart';
import 'package:literahub/screens/peminjamanbuku/services/filter.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
// import 'package:literahub/widgets/list_card.dart';

class ReturnBookPage extends StatefulWidget {
  const ReturnBookPage({Key? key}) : super(key: key);

  @override
  _ReturnBookPageState createState() => _ReturnBookPageState();
}

class _ReturnBookPageState extends State<ReturnBookPage> {

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
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Halaman Pengembalian',
          ),
          backgroundColor: const Color(0xFFC9C5BA),
          foregroundColor: Colors.black,
        ),
        drawer: const LeftDrawer(),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Color(0xFFEDECF2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Click gambar buku untuk mengembalikan",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFC9C5BA)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ), 
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Kembali'),
                    ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                  margin: EdgeInsets.only(left: 5),
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0), // Membulatkan sudut
                    border: Border.all(
                      color: Colors.black,
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
                const SizedBox(height: 10),
                FutureBuilder(
                  future: _filtered.getFilteredPeminjaman(request: request, search: search),
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
                                  color: Color(0xff59A5D8), fontSize: 20),
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
                                Navigator.push(context, MaterialPageRoute( builder: (context) => BookDetailPage(snapshot.data![index])));
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 10),
                                  margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                                  decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                        BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 2/3,
                                        child: Image.network(
                                        '${snapshot.data![index].fields.gambarBuku}',
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
                                              style: TextStyle(
                                                color:
                                                    Colors.black,
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
          )
        ],
      )
    );
  }
}