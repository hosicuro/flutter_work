import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buttons',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MyButtons(),
    );
  }
}

class MyButtons extends StatelessWidget {
  const MyButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buttons!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text_button(),
            Elevated_Button(),
            Outlined_Button(),
            TextButton_icon(),
            ButtonBar(
              // 이 기능은 버튼의 정렬을 담당한다. 기본적으로는 우측 하단에 차례로 정리한다.
              // 또한 만일 가로 공간이 부족하다면 자동으로 다음 줄로 내려준다.

              // 아래의 기능은 정렬 위치를 결정한다.
              alignment: MainAxisAlignment.center,
              // 아래의 기능은 모든 버튼에 padding을 적용해준다.
              buttonPadding: EdgeInsets.all(20),
              children: [
                Text_button(),
                Elevated_Button(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TextButton_icon extends StatelessWidget {
  const TextButton_icon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      // 이는 버튼에 기본적으로 아이콘이 들어가는 버튼이다.
      // 아래처럼 하면 버튼이 비 활성화 된다.
      onPressed: null,
      icon: Icon(
        Icons.home,
        size: 30.0,
        color: Colors.black87,
      ),
      label: Text('Go to home'),
      style: TextButton.styleFrom(
        // 이때 말 그대로 앞 색상이기에 icon의 설정이 없다면 icon의 색깔은 이걸 따라간다.
        foregroundColor: Colors.purple,
        // 버튼의 최소 크기를 지정해준다. 즉, 텍스트가 짧아도 이 크기는 적어도 유지한다.
        minimumSize: Size(50, 50),
        //
        disabledForegroundColor: Colors.pink,
      ),
    );
  }
}

class Outlined_Button extends StatelessWidget {
  const Outlined_Button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Text("Outlined button"),
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          // 이것은 외곽 테두리가 있는 버튼이다.
          // 아래는 외곽 테두리에 대한 속성을 결정한다.
          side: BorderSide(
            color: Colors.black87,
            width: 2.0,
          )),
    );
  }
}

class Elevated_Button extends StatelessWidget {
  const Elevated_Button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Elevated button'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.redAccent,
        // 이것은 외곽 도형이 있는 버튼이다.
        // 아래는 버튼의 외각 모양을 구성한다.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
      ),
    );
  }
}

class Text_button extends StatelessWidget {
  const Text_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      // 아래의 기능은 길게 눌렀을 때의 기능이다.
      // 다만 아래와는 달리 위는 무조건 필요한 기능이다.
      onLongPress: () {},
      // 이 버튼은 기본적으로 배경이 없는 버튼이다.
      // 이제 버튼의 style은 이렇게 구성한다.
      style: TextButton.styleFrom(
        foregroundColor: Colors.red,
        //backgroundColor: Colors.blue,
      ),
      child: Text(
        'Text Button',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
