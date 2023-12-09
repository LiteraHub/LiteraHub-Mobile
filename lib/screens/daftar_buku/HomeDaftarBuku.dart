import 'package:flutter/material.dart';
import 'package:literahub/screens/daftar_buku/tes1.dart';
import 'package:literahub/screens/daftar_buku/tes2.dart';
import 'package:literahub/screens/daftar_buku/widgets/list_daftarbuku.dart';
import 'package:literahub/widgets/left_drawer.dart';
// import 'package:literahub/widgets/list_card.dart';

class HomeDaftarBuku extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Buku',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4C53A5),
          ),
        ),
      ),
      drawer: const LeftDrawer(),
      body: ListView(
        children: [
          Container(
            //temporary height
            // height: MediaQuery.of(context).size.height,
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

                //Search Widget
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      height: 50,
                      width: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search title/author/year book here...",
                        ),
                      ),
                    )
                  ],),
                ),

              //Popular book title
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  vertical: 20, 
                  horizontal: 10
                ),
                child: Text(
                  "Through books, we embark on adventures that transcend time and space.",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ),

              // Container(
              //   child: GridView.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 5,
              //       childAspectRatio: 1.1,
              //       mainAxisSpacing: 25,
              //     ),
              //     shrinkWrap: true,
              //     itemCount: snapshot.data!.length,
              //   )
              // ),

              // Popular Book
              // const ListDaftarBuku2(),
              
              //items
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(
                  vertical: 20, 
                  horizontal: 19
                ),
                child: Text(
                  ""
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
