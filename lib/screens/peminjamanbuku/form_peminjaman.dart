import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:literahub/widgets/left_drawer.dart';

class PeminjamanForm extends StatefulWidget {
  const PeminjamanForm({Key? key}) : super(key: key);

  @override
  State<PeminjamanForm> createState() => _PeminjamanFormState();
}

class _PeminjamanFormState extends State<PeminjamanForm>{
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengembalian Buku',
          style: TextStyle(
          fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: const Color.fromARGB(255, 42, 33, 0),
        backgroundColor: const Color(0xFFC9C5BA),
      ),
      backgroundColor: const Color.fromARGB(255, 242,238,227),
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
                  decoration: const InputDecoration(
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
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return DropdownButton<String>(
                        value: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value!;
                            _judulBuku = value;
                          });
                        },
                        isExpanded: true,
                        isDense: true,
                        items: snapshot.data!.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                        itemHeight: 60,
                        underline: Container( // Add an underline (divider) below the dropdown
                        height: 1,
                        color: Colors.grey,
                      ),  
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
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
                          "https://literahub-e08-tk.pbp.cs.ui.ac.id/peminjamanbuku/pinjam_buku_flutter/",
                          jsonEncode(<String,String>{
                            'name': _namaPeminjam,
                            'tanggal':_selectedDate,
                            'judul':_judulBuku
                          }));
                        if (respons['status'] == 'success') {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Item baru berhasil disimpan!")));
                            if (!context.mounted) return;
                            Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const PeminjamanBukuPage()),
                            );
                          } else {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Terdapat kesalahan, silakan coba lagi.")));
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
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