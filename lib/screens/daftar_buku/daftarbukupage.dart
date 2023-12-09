import 'package:flutter/material.dart';
import 'package:literahub/models/buku.dart';

class DaftarBukuPage extends StatelessWidget {
  final Buku item;

  DaftarBukuPage(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // // Memunculkan SnackBar ketika diklik
          // // Navigate ke route yang sesuai (tergantung jenis tombol)
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => DetailProduct(item.pk),
          //     ));
        },
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  )
                ],
              ),
              // InkWell(
              //   onTap: (){},
              //   child: Container(
              //     margin: EdgeInsets.all(10),
              //     // child: Image.asset(
              //     //   "apakek",
              //     //   height: 120,
              //     //   width: 120,
              //     // ),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  item.fields.title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF4C53A5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Write comment",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$55",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                    Icon(
                      Icons.shopping_cart_checkout,
                      color: Color(0xFF4C53A5),
                    )
                  ],
                ),
              )
            ]
          )
        )
      )
    );
  }
}