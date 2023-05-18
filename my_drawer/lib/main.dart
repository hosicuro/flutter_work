import 'package:flutter/material.dart';
import 'package:my_drawer/MyDrawer.dart';

void main() {
  runApp((MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appbar',
      //theme: ThemeData(primarySwatch: Colors.red),
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          //title: Text('Appbar!'),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            // 이는 오른쪽부터 아이콘을 추가한다.
            // leading은 좌측에 아이콘을 하나 추가한다.
            // leading은 drawer에 포함되기에 생략되었고, 기능은 actions과 같다.
            // IconButton은 아이콘과 따라오는 기능을 포함한다.
            IconButton(
              icon: Icon(Icons.menu),
              // onPressed는 void 함수가 온다. 즉 기능이 온다는 것이다.
              onPressed: () {},
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: Center());
  }
}

// void flutterToast(String message) {
//   Fluttertoast.showToast(
//     msg: message,
//     gravity: ToastGravity.BOTTOM,
//     backgroundColor: Colors.redAccent,
//     fontSize: 20.0,
//     textColor: Colors.white,
//     toastLength: Toast.LENGTH_SHORT,
//   );
// }
