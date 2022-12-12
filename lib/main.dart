import 'package:goosit/pages/home/home_page.dart';
import 'package:goosit/pages/register/register_page.dart';
import 'package:goosit/pages/signin/signin_page.dart';
import 'package:goosit/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/signin': (context) => SignInPage(),
        '/home': (context) => const HomePage(),
        '/register': (context) => RegisterPage()
      },
    );
  }
}
