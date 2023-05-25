import 'package:flutter/material.dart';
import 'package:my_camera/get_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Camera_app',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => getImage(),
        });
  }
}
