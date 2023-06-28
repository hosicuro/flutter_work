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
  final List<XFile?> _Images = [];
  // 또한 picker.pickVideo()를 통해 비디오 선택이 가능해진다.
  //File? _image; //<- image 변수가 유효값 또는 null 값을 가질 수있음을 나타낸다.

  // 비동기 처리를 통해 이미지를 가져온다. 이는 카메라와 갤러리에서 하나씩 받아올 것이다.
  Future<void> _imagePick(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    if (image?.path != null) {
      // 여기서 image가 null이 될 수 있는지 판단하게 한다.
      // 본질적으로 image 변수가 null을 가질 수 없기에 예외가 발생하는 것을 막아준다.
      setState(() {
        // 아래가 위의 결과이다. '!'는 필연적으로 null이 오지 않음을 보장하기에 null이 온다면 예외가 발생하기 때문이다.
        // 또한 아래는 이미지의 경로를 가져온다. 불필요한 용량을 줄이기 위해 변수에 보관하지는 않는다.
        //_image = File(image!.path);
        _Images.add(XFile(image!.path));
      });
    } else {
      print('non_seleted!');
    }
  }

  Future<void> _imagesPick() async {
    // 아래 변수의 타입이 자동적으로 결정된다. List<XFile>?
    final images = await picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _Images.addAll(images);
      });
    }
  }

  Widget _imagePrint() {
    // 상단에 최대 확장된 gridview를 구현하기 위해 사용했다.
    // 이를 사용하지 않는다면 표현 범위를 초과할 수도 있다!!
    return Expanded(
      // 아래는 list의 기능이다.
      child: _Images.isNotEmpty
          ? GridView(
              // 아래는 gridview를 생성하는 방식이다. 이는 Listview와 비슷하지만 타일뷰가 되는 것이 특징이다.
              // 따라서 좌측 위 부터 순서대로 들어간다.
              // SliverGridDelegateWith는 공통이다. gridDelegate는 그리드의 배열을 결정한다.
              // 반드시 해당 라인에는 crossAxisCount와 maxCrossAxisExtent가 들어가며 이들이 with 뒤에 따라온다.
              // 앞은 1개 행에 나타낼 item 개수로 결정하고, 뒤는 기준이 될 너비 크기로서 gridview를 결정하게 된다.
              // 보통 자주 쓰이는 mainAxisSpacing(수평 padding), crossAxisSpacing(수직 padding), childAspectRatio(item의 가로 세로 비율)등이 추가로 사용된다.
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              // GridView.builder를 사용하는게 일반적이다. 이는 itemcount와 itembuilder를 사용하며 itembuilder는 하위에 container나 column이 와서 반복 형성을 하게 해준다.
              // 또한 Gridview.count도 존재한다.
              // https://eunoia3jy.tistory.com/106
              // children은 []을 사용하지 않고 자체로 List[Widget]을 요구한다.

              // 아래 코드에 대한 설명을 해보자. 여기서 사용되는 개념 중 where은 filter의 개념이다.
              // 즉, _Images에 오는 요소(element)가 null이면 제거하여 구성해준다.
              // map을 통해 각 이미지 요소를 widget요소로 바꾸어 지정해준다.
              // toList는 결과적으로 다시 list로 만들어준다.

              // gridview.builder는 반복문이기에 한번에 할 수 있는 map을 위해 그냥 gridview를 쓴게 아닐까?
              children: _Images.where((element) => element != null).map((e) => _gridPhotoItem(e!)).toList(),
            )
          : const SizedBox(),
      // 그게 아니라면 그냥 빈 sizedbox를 expanded한다.
    );
  }

  Widget _gridPhotoItem(XFile e) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      // 이번 과제에서는 stack을 사용하지 않고 row, column, container를 사용해도 되었지만, 참고 코드에서 stack을 사용했기에 분석해보았다.
      // https://ahang.tistory.com/24 | https://dalgoodori.tistory.com/38
      // stack의 장점은 간단하다, 배치를 원하는 좌표에 지정할 수 있고, 서로 겹쳐서 보일 수 있는, 즉, 우선 순위를 부여할 수 있다. <앞, 그 다음, ..., 뒤, 맨 뒤>
      // 결과적으로 이렇게 지정된 widget을 지정해주며, 위에서 선언한 gridview에 들어가 줄에 3개씩 차례대로 들어간다.
      child: Stack(
        children: [
          Positioned.fill(
            // 이 기능은 남은 모든 부분을 채워버린다. 우리는 여기서 image로 위젯을 가득 채우게 되었다.
            child: Image.file(
              File(e.path),
              fit: BoxFit.cover, // 적절한 모양도 지정하였다. 이는 이미지의 속성이다. 비율을 유지하면서 꽉 채운다.
              // https://devmg.tistory.com/181
            ),
          ),
          Positioned(
              // 초기 지정 위치이다. 이때 top, bottom, left, right로 지정 좌표를 정해줄 수 있다.
              // 이는 해당 widget에서 cancel 버튼을 만들어준다.

              // 아마도 stack을 사용한 이유는 이미지 위에 삭제 버튼을 만들기 위함인 것 같다!

              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _Images.remove(e); // list에서 요소를 제거한다.
                  });
                },
                child: const Icon(
                  Icons.cancel_rounded,
                  color: Colors.black87,
                ),
              ))
        ],
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
              _imagePrint(),
              SizedBox(
                height: 50.0,
              ),
              Row(
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
                      _imagesPick();
                    },
                    child: Icon(Icons.add_to_photos_rounded),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[200],
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Widget _imagePrint() {
//     return Container(
//       color: Colors.white,
//       child: Center(
//         child: _image != null ? Image.file(File(_image!.path)) : Text('non_seleted!'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             //mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Flexible(
//                 flex: 9,
//                 child: _imagePrint(),
//               ),
//               SizedBox(
//                 height: 50.0,
//               ),
//               Flexible(
//                 flex: 1,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         _imagePick(ImageSource.camera);
//                       },
//                       child: Icon(Icons.camera),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white70,
//                         minimumSize: Size(50, 50),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         _imagePick(ImageSource.gallery);
//                       },
//                       child: Icon(Icons.image),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue[200],
//                         minimumSize: Size(30, 50),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }