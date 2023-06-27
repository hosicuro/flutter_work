import 'package:flutter/material.dart';
import 'package:my_t/firebase_options.dart';
import 'package:my_t/put_qrPage.dart';
import 'get_apiPage.dart';
import 'package:my_t/logged_in_page.dart';
import 'set_historyNumPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: LoggedInPage(),
    );
  }
}
