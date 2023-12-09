import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:literahub/widgets/left_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

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
  DateTime _tanggal = DateTime.now();
  TimeOfDay _jam = TimeOfDay.now();
  int _durasiBaca = 0;
  String _tempatBaca = "";

  List<String> _bukuOptions = [];
  List<String> _tempatBacaOptions = [];
  List<int> _durasiOptions = [1, 2, 3, 4, 5];

  Future<void> _fetchTempatBaca() async {
    final response = await http.get(Uri.parse(
        'https://literahub-e08-tk.pbp.cs.ui.ac.id/reservasi/get-tempat-baca'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        _tempatBacaOptions = jsonResponse
            .map((item) => item['fields']['id_tempat'].toString())
            .toList();
      });
    } else {
      throw Exception('Gagal memuat tempat baca');
    }
  }

  Future<void> _fetchBuku() async {
    final response = await http.get(Uri.parse(
        'https://literahub-e08-tk.pbp.cs.ui.ac.id/reservasi/get-buku-json'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        _bukuOptions = jsonResponse
            .map((item) => item['fields']['title'].toString())
            .toList();
      });
    } else {
      throw Exception('Gagal memuat buku');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
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
    return DateFormat('dd-MM-yyyy').format(date);
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
    _fetchTempatBaca();
    _fetchBuku();
  }

  @override
  Widget build(BuildContext context) {
    // final request = context.watch<CookieRequest>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Reservasi LiteraHub',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
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
                    )),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      value: _tempatBaca.isNotEmpty ? _tempatBaca : null,
                      items: _tempatBacaOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Reservasi berhasil'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Nama: $_nama'),
                                      Text('Nomor ponsel: $_noHp'),
                                      Text('Buku: $_buku'),
                                      Text('Tanggal: ${_formatDate(_tanggal)}'),
                                      Text('Jam: ${_formatTime(_jam)}'),
                                      Text('Durasi: $_durasiBaca'),
                                      Text('Tempat Baca: $_tempatBaca'),
                                      // TODO: Munculkan value-value lainnya
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _resetForm(); // Reset form
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          _formKey.currentState!.reset();
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
