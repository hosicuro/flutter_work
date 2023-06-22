import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Imageadd extends StatefulWidget {
  const Imageadd(this.addImageFunction, {Key? key}) : super(key: key);

  final Function(File pickedImage) addImageFunction;
  // 플러터는 함수 또한 인자와 매개변수로 전달할 수 있다.
  // 이를 위해 생성자가 존재하는 위쪽에 선언하게 된다.

  @override
  _ImageaddState createState() => _ImageaddState();
}

class _ImageaddState extends State<Imageadd> {
  File? pickedImage;

  void _get_image() async {
    // 인스턴스 형성
    final imagePicker = ImagePicker();
    // 아래 변수의 타입은 XFile 타입이 된다. 이는 임시 저장 위치를 나타낸다.
    final imageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      // imageQuality: 100,
      maxHeight: 150,
    );
    setState(() {
      // 이는 임시로 가져온 이미지 파일을 실질적인 변수에 담을 수 있도록
      // 경로를 가져오게 된다.
      if (imageFile != null) {
        pickedImage = File(imageFile.path);
      }
    });
    // 위젯 함수에게 이미지 요소를 전달해준다.
    if (pickedImage != null) {
      widget.addImageFunction(pickedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: 150,
      height: 300,
      child: Column(
        children: [
          // 추가할 이미지를 보여줄 곳이다.
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            backgroundImage: pickedImage != null ? FileImage(pickedImage!) : null,
          ),
          SizedBox(
            height: 10,
          ),
          OutlinedButton.icon(
            onPressed: () {
              _get_image();
            },
            icon: Icon(Icons.image),
            label: Text('Add icon'),
          ),
          SizedBox(
            height: 80,
          ),
          TextButton.icon(
            onPressed: () {
              // 현재 화면을 나간다.
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text('Close'),
          ),
        ],
      ),
    );
  }
}
