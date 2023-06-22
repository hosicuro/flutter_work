import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat(this.message, this.userName, this.isMe, this.image, {Key? key}) : super(key: key);

  final String message;
  final String userName;
  final bool isMe;
  final String image;

  @override
  Widget build(BuildContext context) {
    // 해당 row로 지정함으로서 이전에 무시되던 width를 적용하게 된다.
    // listview이기에 없다면 가로 최대 길이를 가지게 된다.
    return Stack(children: [
      Row(
        // 누가 전달한지에 따라 위치를 바꾸어 준다.
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: isMe ? const EdgeInsets.fromLTRB(0, 10, 45, 0) : const EdgeInsets.fromLTRB(45, 10, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Colors.blue,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0)),
              ),
              width: 145,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start, children: [
                Text(
                  userName,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  message,
                  style: TextStyle(color: isMe ? Colors.black : Colors.white),
                ),
              ]),
            ),
          ),
        ],
      ),
      // 우리는 지금 이미지 아래에 채팅이 오게 할 것이다. 살짝 겹치면서도 위치가 구별되도록 하기 위해 stack을 사용했다.
      // 또한 뒤에 온 요소가 앞으로 쌓이기에 이미지가 위로 오도록 아래에 두었다.
      // 또한 위치 조정을 위해 positioned 위젯을 사용한다. (이는 stack에서 사용가능하다.)
      Positioned(
        top: 5,
        right: isMe ? 5 : null,
        left: isMe ? null : 5,
        child: CircleAvatar(
          // url 이미지 주소를 전달해주기 위함이다.
          backgroundImage: NetworkImage(image),
        ),
      )
    ]);
  }
}
