import 'package:flutter/material.dart';

class ScreenA extends StatelessWidget {
  ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('screenA'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Go to screen B'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                // 우리가 main에서 별명 지정을 해주었기에 pushNamed 메소드를 사용한다.

                // 아래의 명령은 navigator가 관리하는 stack 상에 SecondPage가 올라간다는 것이다.
                // 즉, firstPage 위에 올라간다는 것이다.

                // 여기서 context 인자가 들어가는 이유는, 현재 페이지를 찾아 그 위에 push 함수가 route를 올리기 때문이다.
                // 따라서 현재 페이지의 BuildContext의 context가 그대로 들어간다.
                Navigator.pushNamed(context, '/b');
              },
            )
          ],
        ),
      ),
    );
  }
}
