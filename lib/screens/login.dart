import 'package:literahub/screens/menu.dart';
import 'package:literahub/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../widgets/customScaffold.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return CustomScaffold(
        showBackArrow: true,
        backArrowColor: Colors.white,
        child: Column(children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
              flex: 7,
              child: Container(
                  padding: EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                  decoration: BoxDecoration(
                      color: Colors.brown.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      )),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const SizedBox(height: 20.0),
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontFamily: 'Prompt',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                              labelText: 'Username',
                              hintText: 'Enter your username',
                              hintStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          obscureText: true,
                          obscuringCharacter: '*',
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              hintStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () async {
                            String username = _usernameController.text;
                            String password = _passwordController.text;

                            // Cek kredensial
                            // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                            // Untuk menyambungkan Android emulator dengan Django pada localhost,
                            // gunakan URL http://10.0.2.2/
                            final response = await request
                                .login("https://literahub-e08-tk.pbp.cs.ui.ac.id/auth/login/", {
                              'username': username,
                              'password': password,
                            });

                            if (request.loggedIn) {
                              String message = response['message'];
                              String uname = response['username'];
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    content: Text(
                                        "$message Selamat datang, $uname.")));
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Login Gagal'),
                                  content: Text(response['message']),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: const Text('Login'),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()),
                                );
                              },
                              child: Container(
                                  padding: EdgeInsets.all(2),
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ])))
        ]));
  }
}
