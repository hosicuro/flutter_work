import 'package:flutter/material.dart';
import 'package:my_chat/firebase_options.dart';
import 'package:my_chat/screens/chat_screen.dart';
import 'package:my_chat/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // 아래를 통해 플러터와 firebase가 초기화 된다. 비동기 방식의 초기화를 위해선 플러터 코어가 먼저 초기화 되어야 한다.
  // 코드랩 예시 코드에서도 아래의 firebase 초기화는 다른 곳에서 사용할 수 있지만, 플러터 초기화는 여기서 우선 작업한다.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatting app',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StreamBuilder(
        // 아래 메서드는 인증 상태 변화에 관련된 stream을 반환해준다.
        // 즉, firebase_auth가 인증 상태에 따른 토큰을 관리해 주기 때문에 이 메서드가 state를 전달해준다.
        // 그리고 우리가 로그인, 로그 아웃시에 토큰을 생성, 삭제 해주기에 따로 navigation이 없어도 정상적인 흐름을 가진다.

        stream: FirebaseAuth.instance.authStateChanges(),
        // 해당 메서드가 관리하여 수시로 값을 전달해주기 때문이다.
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return LoginSignupScreen();
        },
      ),
    );
  }
}
