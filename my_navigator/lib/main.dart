import 'package:flutter/material.dart';
import 'ScreenA.dart';
import 'ScreenB.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // 이제 여러 페이지를 동시에 관리할 pushNamed 메소드를 사용하자.
      // 우리가 첫 상위 클래스에서 home으로 부르는 것 또한 가장 처음의 route를 부르는 것이다!
      // 이때 initialroute는 가장 처음 부를 route를 할당해주며, home와 같은 역할을 수행한다. 따라서 동시에 존재할 수 없다.

      // 여기에는 home 대신 initialRoute 인자를 사용한다.
      // MaterialApp 위젯에는 다중 페이지 관리를 위해 routes와 initialRoute 인자를 가진다.
      // 이때 routes는 <String, WidgetBuilder>{} 이라는 Map 자료 구조를 사용한다. [딕셔너리]
      // 이때 각 route에 String 별명을 선언하여, builder를 할당해주게 된다.

      initialRoute: '/',
      routes: {
        '/': (context) => ScreenA(),
        '/b': (context) => ScreenB(),
      },
    );
  }
}

// route는 우리가 앱에서 볼 수 있는 화면이나 페이지를 뜻한다. 이때 네비게이터는 route 객체들을 stack을 통해 관리한다.
// 이때 Widget tree 구조를 보면 FirstPage 위젯(route)은 MyApp이 MaterialApp을 호출하고, 이 위젯이 FirstPage를 home으로 호출하기에 정상적으로 실행중이다.
// 그렇기에 SecondPage 위젯을 그 어디에서도 호출하지 않았기에 존재하지 않는다.
// 또한 모든 내부 실행 위젯은 MatrialApp 아래에서 호출되며 실행되고 있어야 한다.
// 따라서 우리가 push 메소드를 사용할 때 MaterialApp 하위 위젯에서 context를 받아야 한다.
// 위와 같이 바로 MyApp에서 받는다면, context는 도저히 MaterialApp을 찾을 수 없기에 오류가 나게 된다.

// 이후 완성이 끝난 후에, Widget tree 구조를 보면 SecondPage가 할당되어 있으며, FirstPage 위에 위치한 것을 볼 수 있다.
// 이후 pop 명령이 지난 후에는 다시 비 할당 되는 것을 볼 수 있다.