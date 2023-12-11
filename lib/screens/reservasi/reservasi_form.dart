import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:literahub/models/buku.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:literahub/models/tempat_baca.dart';
import 'package:literahub/screens/reservasi/reservasi_main.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReservasiFormPage extends StatefulWidget {
  const ReservasiFormPage({Key? key}) : super(key: key);

  @override
  State<ReservasiFormPage> createState() => _ReservasiFormPageState();
}

class _ReservasiFormPageState extends State<ReservasiFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _nama = "";
  String _noHp = "";
  String _buku = "";
  int _bukuID = 0;
  DateTime _tanggal = DateTime.now();
  TimeOfDay _jam = TimeOfDay.now();
  int _durasiBaca = 0;
  String _tempatBaca = "";

  List<String> _bukuOptions = [];
  List<int> _tempatBacaOptions = [];
  final List<int> _durasiOptions = [1, 2, 3, 4, 5];
  Map<String, int> _judulToPkMap = {};

  Future<List<TempatBaca>> _fetchTempatBaca() async {
    var url = Uri.parse(
        'https://literahub-e08-tk.pbp.cs.ui.ac.id/reservasi/get-tempat-baca');
        // 'http://127.0.0.1:8000/reservasi/get-tempat-baca');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object TempatBaca
    List<TempatBaca> list_tempat = [];
    for (var d in data) {
      if (d != null) {
        list_tempat.add(TempatBaca.fromJson(d));
      }
    }
    return list_tempat;
  }

  Future<List<Buku>> _fetchBuku() async {
    var url = Uri.parse(
        'https://literahub-e08-tk.pbp.cs.ui.ac.id/reservasi/get-buku-json');
        // 'http://127.0.0.1:8000/reservasi/get-buku-json');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Buku
    List<Buku> list_buku = [];
    for (var d in data) {
      if (d != null) {
        Buku buku = Buku.fromJson(d);
        list_buku.add(buku);
        _judulToPkMap[buku.fields.title] = buku.pk;
      }
    }
    return list_buku;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _tanggal)
      setState(() {
        _tanggal = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _jam,
    );
    if (picked != null && picked != _jam)
      setState(() {
        _jam = picked;
      });
  }

  // Fungsi untuk memformat DateTime menjadi string
  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Fungsi untuk memformat TimeOfDay menjadi string
  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dt);
  }

  void _resetForm() {
    setState(() {
      _buku = "";
      _tanggal = DateTime.now();
      _jam = TimeOfDay.now();
      _durasiBaca = 0;
      _tempatBaca = "";
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTempatBaca().then((tempatBacaList) {
      setState(() {
        _tempatBacaOptions = tempatBacaList
            .map((tempatBaca) => tempatBaca.fields.idTempat)
            .toList();
      });
    });
    _fetchBuku().then((bukuList) {
      setState(() {
        _bukuOptions = bukuList.map((buku) => buku.fields.title).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    var mapJsonData = request.jsonData;
    var username = mapJsonData['username'];
    // print(username);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Reservasi LiteraHub',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        foregroundColor: const Color.fromARGB(255, 42, 33, 0),
        backgroundColor: const Color(0xFFC9C5BA),
      ),
      backgroundColor: const Color.fromARGB(255, 242,238,227),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Input Nama
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        hintText: 'Masukkan nama Anda',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            _nama = value;
                          });
                        }
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                    )),

                // Input Nomor Ponsel
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nomor Ponsel',
                      hintText: 'Masukkan nomor ponsel Anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _noHp = value;
                        });
                      }
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor ponsel tidak boleh kosong';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        // Regex untuk memeriksa string hanya berisi angka
                        return 'Nomor ponsel harus berupa angka!';
                      }
                      return null;
                    },
                  ),
                ),

                // Input Buku
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      value: _buku.isNotEmpty ? _buku : null,
                      items: _bukuOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _buku = newValue!;
                          _bukuID = _judulToPkMap[newValue]!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Buku',
                        hintText: 'Pilih buku',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Buku harus dipilih';
                        }
                        return null;
                      },
                    )
                  ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      value: _tempatBaca.isNotEmpty ? _tempatBaca : null,
                      items: _tempatBacaOptions.map((int value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _tempatBaca = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Tempat Baca',
                        hintText: 'Pilih tempat baca',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Tempat baca harus dipilih';
                        }
                        return null;
                      },
                    )),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                        'Tanggal: ${DateFormat('dd/MM/yyyy').format(_tanggal)}'),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Jam: ${_jam.format(context)}'),
                      trailing: Icon(Icons.access_time),
                      onTap: () => _selectTime(context),
                    )),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: _durasiOptions.map((int value) {
                      return ListTile(
                        title: Text('$value jam'),
                        leading: Radio<int>(
                          value: value,
                          groupValue: _durasiBaca,
                          onChanged: (int? newValue) {
                            setState(() {
                              _durasiBaca = newValue!;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await request.postJson(
                              // "http://localhost:8000/reservasi/create-flutter/",
                              "https://literahub-e08-tk.pbp.cs.ui.ac.id/reservasi/create-flutter/",
                              jsonEncode(<String, String>{
                                'nama': _nama,
                                'no_hp': _noHp,
                                'buku': _bukuID.toString(),
                                'tempat_baca': _tempatBaca,
                                'tanggal': _formatDate(_tanggal),
                                'jam': _formatTime(_jam),
                                'durasi_baca': _durasiBaca.toString(),
                                'user': username, 
                              }));
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Reservasi berhasil dibuat!"),
                            ));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPageReservasi()),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Terdapat kesalahan, silakan coba lagi."),
                            ));
                          }
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
