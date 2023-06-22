import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _userEnterMessage = '';
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    // 아래의 기능을 통해 현재 인증되어 있는 유저의 정보를 불러온다.
    final user = FirebaseAuth.instance.currentUser;
    // 아래의 기능을 통해 매번 메시지 생성 시 마다, 유저의 이름을 가지게 하였다.
    final userData = await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
    // get 메서드가 future 타입임을 인지하자!
    FirebaseFirestore.instance.collection('chat').add({
      'text': _userEnterMessage,
      // 이 기능은 firestore에서 제공된다.
      'time': Timestamp.now(),
      // 이는 메세지를 보낸 유저를 구분한다. 이후 유저의 정보를 함께 보관한다.
      'userID': user.uid,
      'userName': userData.data()!['userName'],
      'userImage': userData.data()!['image'],
    });
    // 보낸 후에는 컨트롤러 내용이 사라지게 하였다.
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 입력 필드와 타일 간의 간격을 조성한다.
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            // 이번에는 form을 사용할 필요까지는 없다.
            // Expanded를 사용하지 않으면 모든 공간을 차지하여 문제가 발생한다.
            child: TextField(
              // 이는 필드에 최대로 보일 수 있는 lines의 개수이다.
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(
                // 이 기능은 텍스트 필드 내에서 입력 전에 보여줆 메시지가 된다.
                labelText: 'Send a message...',
              ),
              onChanged: (value) {
                // 이는 해당 필드의 value 입력의 변화마다 상태를 변경해준다.
                setState(() {
                  _userEnterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            // 텍스트 입력 값의 양 끝을 제거한 것이 비었을 때는 null으로 비 활성화 해준다.
            // 그렇지 않다면 활성화 하여 전송 메서드를 사용하게 한다.

            // 그리고 _sendMessage에 대한 반환 값을 받을 필요가 없기에 괄호를 빼준다.
            onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
