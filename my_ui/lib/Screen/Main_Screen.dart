import 'package:flutter/material.dart';
import 'package:my_ui/Widget/text.dart';

class Main_Screen extends StatefulWidget {
  const Main_Screen({super.key});

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  List<Box> lists = [
    Box(icon: Icons.add, name: 'This is add'),
    Box(icon: Icons.remove, name: 'This is remove'),
    Box(icon: Icons.close, name: 'This is close or clear'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'MAIN',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.login_outlined),
            color: Colors.black,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          )
        ],
      ),
      body: Column(
        children: [
          // "..."연산자는 확산 연산자이다.
          for (int i = 0; i < lists.length; i++) ...[
            MyBox(
              box: lists[i],
              delete: () {
                setState(() {
                  lists.remove(lists[i]);
                });
              },
            ),
            SizedBox(height: 20), // Add spacing between items
          ],
        ],
      ),
    );
  }
}
