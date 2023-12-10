import 'package:flutter/material.dart';
import 'package:literahub/screens/lembarasa/all_buku_user.dart';
import 'package:literahub/screens/lembarasa/buku_user.dart';
import 'package:literahub/screens/lembarasa/lembarasa_form.dart';
import 'package:literahub/widgets/left_drawer.dart';

class LembarAsaMain extends StatelessWidget {
  LembarAsaMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LiteraHub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFC9C5BA),
        foregroundColor: Colors.black,
      ),
      drawer: const LeftDrawer(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    'LembarAsa',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add your create button functionality here
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LembarAsaFormPage()),
                        );
                      },
                      child: const Text('Create'),
                    ),
                    const SizedBox(width: 10), // Adding some space between buttons
                    ElevatedButton(
                      onPressed: () {
                        // Add your show button functionality here
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyBukuPage()),
                        );
                      },
                      child: const Text('Show'),
                    ),
                    const SizedBox(width: 10), // Adding some space between buttons
                    ElevatedButton(
                      onPressed: () {
                        // Add your show button functionality here
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UserMyBukuPage()),
                        );
                      },
                      child: const Text('Show2'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
