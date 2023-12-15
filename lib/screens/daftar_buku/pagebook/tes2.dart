import 'package:flutter/material.dart';
import 'package:literahub/models/buku.dart';
import 'package:literahub/screens/daftar_buku/api_services/API_services.dart';
import 'package:literahub/screens/daftar_buku/pagebook/detail%20buku/bookinfopage.dart';
// import 'package:literahub/widgets/list_card.dart';

class ListDaftarBuku2 extends StatefulWidget {
  const ListDaftarBuku2({Key? key}) : super(key: key);

  @override
  _ListDaftarBuku2State createState() => _ListDaftarBuku2State();
}

class _ListDaftarBuku2State extends State<ListDaftarBuku2> {
  final FetchBook _bookList = FetchBook();
  var query;

  
  void updateList(String value){
    String searchTerm = value.trim().toLowerCase();
    setState(() {
      if(query != ""){
        query = searchTerm;
      }
      else{
        query = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Buku'),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                color: Color(0xFFEDECF2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [

                  //Search Widget
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            onChanged: (value) => updateList(value),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search title/author/year book here...",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //Popular book title
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Text(
                      "Through books, we embark on adventures that transcend time and space.",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                  ),


                  FutureBuilder<List<Buku>>(
                      future: _bookList.getBookList(query: query),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          if (!snapshot.hasData || snapshot.data!.length == 0) {
                            return const Column(
                              children: [
                                Text(
                                  "Tidak ada buku.",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                SizedBox(height: 1000),
                              ],
                            );
                          } else {
                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.55,
                                  mainAxisSpacing: 25,
                                ),
                                // physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index) => Container(
                                      child: InkWell(
                                          onTap: () {
                                            // Memunculkan SnackBar ketika diklik
                                            // Navigate ke route yang sesuai (tergantung jenis tombol)
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailBukuPage(snapshot
                                                          .data![index].pk),
                                                ));
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 15, top: 10),
                                              margin: const EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Column(
                                                  // crossAxisAlignment:
                                                  //     CrossAxisAlignment
                                                  //         .stretch,
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: const BoxDecoration(
                                                        color: Colors.amber,
                                                      ),
                                                      child: AspectRatio(
                                                        aspectRatio: 2/3,
                                                        child: Image.network(
                                                          snapshot.data![index].fields.img,
                                                          // width: 500,
                                                          // height: 300,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    ),
                                                    Container(
                                                      padding:const EdgeInsets.all(20),
                                                      child: Align(alignment:Alignment.center,
                                                        child: RichText(
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          strutStyle:
                                                              const StrutStyle(fontSize:10.0),
                                                          text: TextSpan(
                                                            style: const TextStyle(
                                                              color:Colors.black,
                                                              fontSize: 15,
                                                            ),
                                                            text:
                                                                '${snapshot.data![index].fields.title}',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]))),
                                    ));
                          }
                        }
                      })
                ],
              ),
            )
          ],
        ));
  }
}
