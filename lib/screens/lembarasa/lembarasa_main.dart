import 'package:flutter/material.dart';
import 'package:literahub/screens/lembarasa/all_buku_user.dart';
import 'package:literahub/screens/lembarasa/buku_user.dart';
import 'package:literahub/screens/lembarasa/lembarasa_form.dart';
import 'package:literahub/widgets/left_drawer.dart';

class LembarAsaMain extends StatelessWidget {
  const LembarAsaMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LembarAsa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFC9C5BA),
        foregroundColor: Colors.black87,
      ),
      drawer: const LeftDrawer(),
      backgroundColor: const Color.fromARGB(255, 242, 238, 227),
      body: SingleChildScrollView (
        child: Align(
          alignment: Alignment.topCenter,
        
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 60.0),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFC9C5BA),
                      boxShadow: [
                        BoxShadow(
                          color:  Color(0xFFC9C5BA),
                          blurRadius: 2.5,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.mode_edit_outline_outlined,
                        size: 120.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                const Center(
                  child: Text(
                    'Karya unikmu, dunia digital kami',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Unggah bukumu dan biarkan semua orang terinspirasi',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LembarAsaFormPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC9C5BA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: const Size(225.0, 50.0),
                  ),
                  child: const Text(
                    'Mulai Berkarya',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserMyBukuPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC9C5BA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), 
                    ),
                    minimumSize: const Size(225.0, 50.0),
                  ),
                  child: const Text(
                    'Karyaku',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 90.0),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFC9C5BA),
                      boxShadow: [
                        BoxShadow(
                          color:  Color(0xFFC9C5BA),
                          blurRadius: 2.5,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.menu_book_rounded,
                        size: 120.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                const Text(
                  'Otak yang cerdas berfikir sejalan',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const Text(
                  'Jelajahi LembarAsa sekarang',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyBukuPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC9C5BA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: const Size(225.0, 50.0),
                  ),
                  child: const Text(
                    'Eksplorasi',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 70.0,)
              ],
            ),
          ),
        ),
      )
    );
  }
}
