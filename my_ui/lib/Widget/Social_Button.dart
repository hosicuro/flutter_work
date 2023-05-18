import 'package:flutter/material.dart';

class Social_Button extends StatelessWidget {
  final Color color;
  final Widget image;
  final Widget text;

  Social_Button({super.key, required this.color, required this.image, required this.text});

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
