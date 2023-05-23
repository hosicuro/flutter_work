import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';

class Main_Screen extends StatefulWidget {
  const Main_Screen({super.key});

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  // 지속적으로 주사위의 모양이 변경되기에

  int leftDice = 1;
  int rightDice = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'DICE',
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  // 이때 아래와 같은 기능을 추가해야 하는 이유는, Row 위젯을 추가하였기에 세로 가운데에서 가로로 길게 공간이 만들어졌기 때문이다.
                  // 이로 인해 row를 가운데 정렬 하기 위해 추가할 수 있다.
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      // 아래의 기능은 가능한 공간을 모두 차지하라는 의미가 되며, flex에 의해 Row 내부의 flexible 위젯이 공간을 나눠 가진다.
                      fit: FlexFit.tight,
                      flex: 2,
                      child: Image.asset('assets/dice$leftDice.png'),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: Image.asset('assets/dice$rightDice.png'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    leftDice = Random().nextInt(6) + 1;
                    rightDice = Random().nextInt(6) + 1;
                  });
                  flutterToast("Left dice: {$leftDice}, right dice: {$rightDice}");
                },
                child: Icon(
                  Icons.play_arrow,
                  size: 50.0,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.white,
                ),
              )
            ],
          ),
        ));
  }
}

void flutterToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.brown,
    fontSize: 20.0,
    textColor: Colors.black,
    toastLength: Toast.LENGTH_SHORT,
  );
}
