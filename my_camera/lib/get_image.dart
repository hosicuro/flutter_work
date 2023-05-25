import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class getImage extends StatefulWidget {
  const getImage({super.key});
  @override
  State<getImage> createState() => _getImageState();
}

class _getImageState extends State<getImage> {
  final ImagePicker picker = ImagePicker();
  //List<XFile> _Images = []; <- 우리가 여러 장의 이미지를 선택할 때
  // picker.pickMultiImager() 메서드와 함께 사용할 것이지만, 아직은 구현하지 않았다.
  // 또한 picker.pickVideo()를 통해 비디오 선택이 가능해진다.
  File? _image; //<- image 변수가 유효값 또는 null 값을 가질 수있음을 나타낸다.

  // 비동기 처리를 통해 이미지를 가져온다.
  Future<void> _imagePick(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    if (image?.path != null) {
      // 여기서 image가 null이 될 수 있는지 판단하게 한다.
      // 본질적으로 image 변수가 null을 가질 수 없기에 예외가 발생하는 것을 막아준다.
      setState(() {
        // 아래가 위의 결과이다. '!'는 필연적으로 null이 오지 않음을 보장하기에 null이 온다면 예외가 발생하기 때문이다.
        // 또한 아래는 이미지의 경로를 가져온다. 불필요한 용량을 줄이기 위해 변수에 보관하지는 않는다.
        _image = File(image!.path);
      });
    } else {
      print('non_seleted!');
    }
  }

  Widget _imagePrint() {
    return Container(
      color: Colors.white,
      child: Center(
        child: _image != null ? Image.file(File(_image!.path)) : Text('non_seleted!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 9,
                child: _imagePrint(),
              ),
              SizedBox(
                height: 50.0,
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _imagePick(ImageSource.camera);
                      },
                      child: Icon(Icons.camera),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        minimumSize: Size(50, 50),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _imagePick(ImageSource.gallery);
                      },
                      child: Icon(Icons.image),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[200],
                        minimumSize: Size(30, 50),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
