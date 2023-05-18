import 'package:flutter/material.dart';
// 이것은 플러터 sdk에 위치하는 material 라이브러리를 가져온다.
// 기본적으로 제공되는 위젯, 디자인, 테마 요소를 사용할 수 있기 때문이다.
// 또한 모바일, 데스크톱을 포함한 다양한 디바이스를 아우르는 디자인을 위해
// 구글이 지정된 머테리얼 디자인 또한 포함된다.

void main() {
  // app의 시작점
  runApp(MyApp());
  // runAPP은 최상위 함수가 된다. 한번만 실행하면 된다.
  // 그리고 이는 전달인자로 위젯이 들어가야 한다.
  // 전달되는 MyApp은 우리가 커스텀 해주는 위젯이다.
  // 즉, 프로젝트 위젯이 되는 것이다. 이는 우리가 이름을 지정해 줄 수 있다.
  // 이렇게 불러와지는 위젯은 최상위 위젯으로 스크린 레이아웃을 처음 지정해 주게 된다.
  // 지금 확인하는 것 처럼 위젯은 클래스이다.
}

// stl 명령어를 사용하여 자동 생성해주자!!

// 우리가 커스텀 해주는 위젯이다. 이는 기본 프레임워크 위젯이 아니어서 만들어 주어야 한다.
// 이때 이 위젯은 StatelessWidegt을 상속받게 된다. 이는 프로젝트의 레이아웃을 만들기에
// 어떤 변화나 기능이 없다. 그렇기에 이를 상속받는다.
class MyApp extends StatelessWidget {
  // 여기서 지정해주게 되는 위젯은, 앱의 패키지가 된다.
  // 즉,앱의 외부를 꾸며주며, 실질적인 앱의 기능은 home:에서 진행하게 될 것이다.
  const MyApp({super.key});

  // This widget is the root of your application.
  // statelessWidget을 자동 완성으로 입력받게 되면 아래 기본적인 함수가 만들어진다.
  // 즉 클래스 형태와 key unit, return만 기본으로 주어진다.
  @override
  Widget build(BuildContext context) {
    // 위젯 클래스를 반환하는 build 함수는 다른 위젯을 형성하여 반환한다.
    // 이는 커스텀 위젯의 공통적인 특징이다.
    // 따라서 MaterialApp이라는 위젯을 리턴하게 된다.
    // 이때 우리는 앞서 배운 기본 프레임워크를 작동할 수 있는 위젯인 MaterialApp을 반환하게 되는 것이다.
    return MaterialApp(
      // 먼저 MaterialApp은 앱의 title을 결정하는 인자를 가진다.
      title: 'MyApp',
      // 그 후 기본 테마인 ThemeDate 위젯을 theme로 지정해준다.
      theme: ThemeData(
        // This is the theme of your application.
        // primarySwatch는 단색을 사용하게 되는 primaryColor와는 달리
        // 음영색상, 즉 파란색 계통의 색들을 조화롭게 사용하는 명령어이다.
        primarySwatch: Colors.deepPurple,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // 테마의 색을 결정할 때 주로 사용되는 2가지 방법이다.
        // 이때 colorScheme는 위와는 달리 primary, secondary, background 등과 같이
        // 다양한 상황에서 사용할 수 있다.
        // 따라서 단일 요소의 색을 결정할 때는 더 편리한 primarySwatch를 사용하자.
        useMaterial3: false,
        // 이 기능은 google material design에서 신규 기능을 사용할 수 있도록 한다.
        // 다만 이는 primarySwatch 기능을 덮어 써 버리기에, 아래에서 출력되는
        // Scaffold에서 AppBar의 backgroundColor 기능을 사용해야 정상적으로
        // Bar의 색이 나오게 된다.
      ),
      home: MyHomePage(),
      // 이 기능은 app에서 가장 먼저 실행되는 명령의 집합이다.
      // 우리는 MyHomePage라는 커스텀 위젯을 형성하였고, 이것에 있는 요소들이
      // 가장 먼저 실행 되게 될 것이다. 즉, 존재하지 않는다면 실행했을 때 아무 요소도 나오지 않게 된다.
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 앱 페이지의 화면 출력을 담당하는 Scaffold 위젯을 반환한다. 마치 빈 도화지와 같다.
    return Scaffold(
      // 이는 App의 상단 바를 담당한다.
      appBar: AppBar(
        // 위의 MaterialApp과는 달리 Text 위젯을 사용한 이유는 위는 앱을 총칭하는 명칭이 된다.
        // 스마트폰 상에서 여러 요소를 통해 앱을 관측할 때 해당 title이 사용된다.
        // 그러나 지금 사용되는 title은 AppBar 위에 올라가는 유닛이기에 따로 지정되는 것이다.
        title: Text('My first App'),
        centerTitle: true,
        // 이는 가운데 정렬의 옵션을 추가한다.
        //backgroundColor: Colors.*,
        // appbar의 색상을 바꾸게 된다.
        elevation: 10.0,
        // 이 기능은 고도라는 의미가 되어, appbar에 그라데이션 처럼 약간 떠 있는 효과를 조정한다.
      ),
      body: Center(
        // child는 간단히 말해 Center이라는 위젯의 자식 위젯이 된다.
        // 즉, Center의 영향을 받고자 하는 요소를 뜻한다.
        // 추가적으로 child 내부에 Column 요소를 추가하여 새로로 쌓이는 텍스트 기둥을 세울 수도 있다.
        // 이때 Center은 Text라는 위젯 하나를 가지니 child를 사용한다. <한번 선언으로 여러 개의 텍스트 운용>
        // 반면 Column은 여러 요소를 한번에 열을 세우게 되니 Children을 사용하게 됨을 이해하자!
        // 이는 앱의 중요한 환경을 만들게 되니, 중요한 요소가 된다.
        // Center을 통해 모든 추가되는 요소가 가운데로 오게 된다.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // 정렬을 해당하는 축<여기서는 Center>을 기준으로 가운데에 정렬한다.
          // 따라서 이 상태의 출력은 정 가운데에 정렬 될 것이다.
          // 이 기능을 사용하지 않게 된다면, Column 위젯 특성 상, 세로 축의 크기가 지정되지 않는다.
          // 따라서 상단으로 무조건 지정된다. 위의 기능을 사용하면, 요소들의 크기를 합하여 자동 정렬을 해주게 된다.
          children: <Widget>[
            // 이때 <Widget>은 대상 지정이다. 즉, 위젯을 대상으로 행 지정 하겠다는 의미가 된다.
            // 그러나 최신 버전에서는 필요하지 않은 요소가 되었다.
            Text('Hello'),
            Text('Hello'),
            Text('Hello'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          // 플러터에서 액션 버튼을 추가한다.
          onPressed: () {
            // 가장 기본적인 onPressed 버튼이다. 이는 버튼이 눌릴 때 동작한다.
            print("디버깅!");
            // 이는 디버그 콘솔에 나타날 text가 된다.
          },
          child: Text('button!')),
      // 버튼 위에 표시될 Text를 결정한다.
    );
  }
}
