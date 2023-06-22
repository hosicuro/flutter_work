import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat/chatting/chat/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 이곳은 들어온 메시지를 보관하여 보여주기에 streambuilder를 사용한다.
    // 이러한 streambuilder는 플러터가 제공하지만, stream의 관리는 cloud_firestore에서 정의된다.

    // 이렇듯 firestore 상에서의 collection 경로를 제공하고 이를 shapshot이 데이터 변화시마다 전달하게 된다.
    // 그런데 StreamBuilder가 결과적으로 전달해주기에 listener는 필요가 없어진다.

    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      // 아래의 부분은 수정되었다. 이제는 단지 chat 이하로 컬랙션이 존재하지 않는다.

      stream: FirebaseFirestore.instance.collection('chat').orderBy('time', descending: true).snapshots(),
      // orderby 기능은 매번 요소를 가져올 때 순서 정렬을 하도록 만든다.

      // 아래는 자동 추가 기능을 이용하자. 이는 context와 snapshot의 최신 데이터를 가져오기 위한 AsyncSnapshot을 이용한다.
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            // 이때 데이터가 로딩되는 동안에 출력할 수 없으니 그 동안에는 돌아가는 로딩 화면을 출력한다.
            child: CircularProgressIndicator(),
          );
        }
        // 중복된 부분을 해결한다. 여기서는 메시지를 보여주기를 담당한다.
        // 여기서 우리가 원하는 정보를 불러올 수 있다. 즉, 데이터에 접근해서 정보를 가져온다.
        // 여기서는 우리가 컬렉션 끝을 기준하였기에 가장 마지막인 문서에 대한 정보이다.
        final chatDocs = snapshot.data!.docs;

        // 그리고 변하는 stream을 불러오기 위해 listview를 이용하였다. 이때 builder는 개수와 build를 요구한다.
        return ListView.builder(
          // 이때 데이터 갱신시에는 rebuild가 되기에 모든 내용이 다시 돌아간다.

          // 이는 채팅이니 거꾸로 올라가게 지정된다.
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) {
            // 모든 과정을 정리해보자. chat_screen은 요소를 출력하고 새로운 요소를 추가할 new_message를 가진다.
            // 이런 new_message는 요소를 추가하며, user.uid를 함께 추가한다.
            // 그리고 message는 화면을 구성하게 되며, 각 요소에 대해 chat에게 정보를 전달하여 추가하게 된다.

            return Chat(
                chatDocs[index].data()['text'],

                // 이때 먼저 여기도 user 정보를 받아야 하니, 변수를 추가해주었고,
                // 뒤에 들어가는 id는 chat에서는 bool 타입이다. 따라서 다음 과정은 비교를 통해 bool을 전달한다.

                chatDocs[index].data()['userName'].toString(),
                chatDocs[index].data()['userID'].toString() == user!.uid,
                chatDocs[index].data()['image'].toString());
          },
        );
      },
    );
  }
}
