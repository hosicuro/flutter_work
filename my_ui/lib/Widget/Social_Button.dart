import 'package:flutter/material.dart';

class Social_Button extends StatelessWidget {
  final Color bg_Color;
  final Color fg_Color;

  // 아래의 요소들은 Image.asset | Text~와 같이 노란색 위젯 형이 오기에 Widget으로 지정해준다.
  final Widget image;
  final Widget text;

  // onpressed를 알기 위해 return 옆 버튼을 들어가보면, onpressed에 마우스를 가져다 댈때 function이 오는 것을 볼 수 있다.

  // 아래의 요소는 생성자이다. named argument를 사용하여 screen에서 버튼을 호출할 때 요소들을 넣어주도록 지정한다.
  Social_Button({Key? key, required this.bg_Color, required this.fg_Color, required this.image, required this.text}) : super(key: key);
  // Key? key ~ : super(key: key)와 중괄호 내부에 super.key는 같다.

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: bg_Color,
          foregroundColor: fg_Color,
          minimumSize: Size(20, 50),
          // 이는 버튼의 가장자리에 대한 모양을 결정해준다.
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ))),
      onPressed: () {},
      child: Row(
        // 아래의 기능은 children의 요소를 모두 같은 간격으로 띄운다. <맨 앞과 맨 끝도 띄운다.>
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          image,
          text,
          // 아래의 기능은 row 맨 끝에 요소를 추가하면서, opacity 투명도를 적용시킨다. 0.0은 투명이다.
          Opacity(
            opacity: 0.0,
            // 맨 앞과 같은 크기의 image를 넣게 되면서 간격을 맞추게 된다.
            child: image,
          )
        ],
      ),
    );
  }
}
