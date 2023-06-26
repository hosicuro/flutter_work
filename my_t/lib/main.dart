import 'package:flutter/material.dart';
import 'package:my_t/put_qrPage.dart';
import 'get_apiPage.dart';
import 'set_historyNumPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
      ),
      home: QrPage(),
    );
  }
}
