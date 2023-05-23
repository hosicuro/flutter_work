import 'package:flutter/material.dart';

class Social_Button extends StatelessWidget {
  final Color color;
  final Widget image;
  final Widget text;

  Social_Button({Key? key, required this.color, required this.image, required this.text}) : super(key: key);
  // Key? key ~ : super(key: key)와 중괄호 내부에 super.key는 같다.

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(20, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ))),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          image,
          text,
          Opacity(
            opacity: 0.0,
            child: image,
          )
        ],
      ),
    );
  }
}
