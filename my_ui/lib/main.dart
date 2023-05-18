import 'package:flutter/material.dart';
import 'Screen/Main_Screen.dart';
import 'Screen/Login_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      initialRoute: '/',
      routes: {
        '/': (context) => Main_Screen(),
        '/login': (context) => Login_Screen(),
      },
    );
  }
}
