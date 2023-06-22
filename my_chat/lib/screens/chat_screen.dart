import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat/chatting/chat/message.dart';
import 'package:my_chat/chatting/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    // 그리고 페이지가 새로 구성될 때 작업이 일어나도록 해도 되기에 initstate에 함수를 넣어보았다.
    super.initState();
    // getCurrentUser();
  }

  void getCurrentUser() {
    // 이전 페이지에서 유저 등록이 되었다면, 이는 _authentication에 잘 등록될 것이다.
    try {
      // 이때 우리는 페이지 이동시에 등록 유저의 이메일을 출력할 것이다.
      // 오류에 대비하여 try-catch 구문을 작성하였다.
      final user = _authentication.currentUser;
      // null이 아닐 때 유저를 등록하고, 이메일을 출력한다.
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat screen'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              _authentication.signOut();
              // Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            // Messages는 listview이기에 expanded가 없다면 화면 전체를 채워버려 오류가 발생한다.
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
