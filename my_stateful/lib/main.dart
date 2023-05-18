import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StatefulApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPage(),
    );
  }
}

// 우리가 이런 버튼입력을 통해 내부 text의 변화를 주고자 할 때
// stateless 위젯을 통해 진행한다면 전혀 변화가 없고,
// 우리가 hot reload 작업 이후에야 변수의 변화가 적용될 것이다.
// 즉, 변수에 변화는 있지만, 이 작업에 대한 변화 감지는 rebuild 과정에서 인지하고 다시 그리라는 명령이 전달된다.
// 이런 이유는 간단하다 stateless 위젯이 immutable하기 때문이다. 즉, 한번 생성된 이후에 변화를 주지 못한다는 것이다.

// stateless위젯과 statefull위젯의 공통은 외부 데이터가 생성자로 들어온 후, build method를 통해 UI를 render한다.
// 이때 다른 점은 statefull위젯에는 state라는 클래스가 별도로 존재한다. 또한 build mathod가 이 state 클래스에 존재하게 된다.
// 이런 statefull이 rebuild 될 때는 마찬가지로 생성자를 통해 데이터가 전달 될 때와 internal state(초기 상태)가 변할 때 발생한다.

// 아래는 stateful로 바꾼 위젯이다. 이때 두 가지의 클래스로 분할되었다.
// 이런 이유는 statefulwidget 또한 immutable하기 때문이다. 그렇기에 변할 수 있는 클래스인 state를 추가로 상속시킴으로서
// 이때 아래의 state를 상속받는 클래스가 state<mypage>인 것은 앞서 배운 타입 핧당으로, mypage만 상속 타입으로 지정한 것이다.
// 즉, 다른 요소들과의 결합으로 인해 발생할 문제를 예방한다.
// 이때 stateful 위젯 클래스 내부에서 사용되는 위젯들 또한 stateful 위젯을 상속받게 되며, 이때도 상속 타입이 지정된다.
// 모든 stateful 위젯은 이런 방식이며 항상 짝을 지어서 할당됨을 알게 되고, 또한 안정성 적인 보호 측면도 있음을 알게 된다.

class MyPage extends StatefulWidget {
  MyPage({super.key});

  @override
  // 이는 매번 갱신될 때마다 이것이 호출되며 이는 아래의 state 클래스와 연결을 지어주게 된다.
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times'),
            // 이후 모든 작업 이후에 버튼을 눌러도 변화가 없다. text 위젯은 stateless 위젯이기에 buildmethod를 호출해야 하기 때문이다.
            // 따라서 이를 가능하게 하는 setstate method를 추가해 줌으로서 단순히 버튼만 누름에도 buildmethod를 호출할 수 있게 한다.

            Text(
              '$count',
              // 이는 텍스트 전반적인 표시 테마를 결정한다.
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    // 버튼을 누르게 되면, setState 함수가 호출된다.
                    // 이때 이 함수는 아래의 명령을 실행함과 동시에 이 변수를 사용하는 모든 위젯을 표시한다.
                    // 변화로 인해 state가 변했고 이에 따라 rebuild 해야 하기 때문이다.
                    // 이런 표현된 위젯을 dirty라고 한다. 위에 count를 사용하는 text가 예시가 될 것이다.
                    // 이제 생각해보자. state object는 변화된 statefull widget에 단순히 연결만 짓게 된다.

                    setState(() {
                      count++;
                    });
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                  child: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (count > 0) {
                        count--;
                      }
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
