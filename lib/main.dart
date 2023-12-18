import 'package:flutter/material.dart';
import 'package:literahub/providers/user_provider.dart';
import 'package:literahub/welcomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()), //for saving user
        Provider(
          create: (_) {
            CookieRequest request = CookieRequest();
            return request;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
