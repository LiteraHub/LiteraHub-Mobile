import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:literahub/models/buku.dart';
import 'package:literahub/screens/peminjamanbuku/peminjamanbuku_page.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class PeminjamanForm extends StatefulWidget {
  const PeminjamanForm({super.key});

  @override
  State<PeminjamanForm> createState() => _PeminjamanFormState();
}

class _PeminjamanFormState extends State<PeminjamanForm> {
  final _formKey = GlobalKey<FormState>();
  String _namaPeminjam = "";
  String _judulBuku = "";
  String _selectedDate = "";
  String? _kepilih;
  String? selectedValue;
  late Future<List<String>> listProduct;

  @override
  void initState() {
    super.initState();
    // Memanggil fungsi fetchProduct di initState
    listProduct = fetchProduct();
  }

  Future<List<String>> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/peminjamanbuku/get-buku-item/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<String> productList = [];
    for (var d in data) {
      if (d != null) {
        Buku buku = Buku.fromJson(d);
        productList.add(buku.fields.title);
      }
    }

    // Pastikan nilai awal selectedValue adalah unik
    selectedValue = productList.isNotEmpty ? productList[0] : null;

    return productList;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null)
      setState(() {
        _kepilih = DateFormat('dd/MM/yyyy').format(picked);
        _selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Peminjaman Buku',
          ),
        ),
        backgroundColor: const Color(0xFFC9C5BA),
        foregroundColor: Colors.black,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Peminjam",
                    labelText: "Nama Peminjam",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _namaPeminjam = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nama peminjam tidak boleh kosong";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "dd/mm/yyyy",
                    labelText: 'Tanggal Pengembalian',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  controller: TextEditingController(text: _kepilih),
                  validator: (String? value) {
                    if (_selectedDate.isEmpty) {
                      return 'Tanggal pengembalian tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<List<String>>(
                  future: listProduct,
                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return DropdownButton<String>(
                        value: selectedValue,
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            selectedValue = value!;
                            _judulBuku = value;
                          });
                        },
                        isExpanded: true,
                        items: snapshot.data!
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFC9C5BA)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ), 
                    onPressed: () async {  
                      if(_formKey.currentState!.validate()){
                        if(_judulBuku == ""){
                          ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                              content:
                              Text("Jangan lupa memilih buku!"),
                            ));
                        }
                        final respons = await request.postJson(
                          "http://127.0.0.1:8000/peminjamanbuku/pinjam_buku_flutter/",
                          jsonEncode(<String,String>{
                            'name': _namaPeminjam,
                            'tanggal':_selectedDate,
                            'judul':_judulBuku
                          }));
                        if (respons['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Item baru berhasil disimpan!"),
                            ));
                            Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => PeminjamanBukuPage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                              content:
                              Text("Terdapat kesalahan, silakan coba lagi."),
                            ));
                          }
                        }
                      }, 
                    child: const Text(
                      "Submit"
                    ),
                  ),
                ),
              ),
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
                )
            ],
          ),
        ),
      ),
    );
  }
}
