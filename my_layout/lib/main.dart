import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Myapp',
      home: Mypage(),
    );
  }
}

class Mypage extends StatelessWidget {
  const Mypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Widget_1(),
      ),
    );
  }
}

class Widget_1 extends StatelessWidget {
  const Widget_1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container 위젯은 크기 지정이 없을 경우 페이지 내에서 최대한의 공간을 차지하려 한다.

      // 따라서 내부 처럼 지정을 한다면 text의 크기에 맞게 배경은 파란색, container는 작게 빨간색 베경으로 만들어진다.
      // 그런데 상태 표시줄 위로 넘어간다. 이를 해결하기 위해 SafeArea 위젯 내부로 넣어주어야 한다.
      // 이를 위해 Container를 블록 하고 Warp with Widget을 사용하자.

      // 또한 너비와 폭을 지정할 수 있다. 이렇게 되면 해당 크기로 지정된다.

      // 그리고 margin과 padding을 사용할 수 있다.
      // margin은 외부 속성, 즉 box의 위치를 결정하며, padding은 child 속성, 즉 text의 위치를 결정한다.
      // 그리고 Container는 반드시 child만 가지게 된다.
      color: Colors.red,
      width: 100,
      height: 100,
      //margin: EdgeInsets.all(20)은 모든 곳에 20을 준다.
      margin: EdgeInsets.symmetric(
        // 이 속성은 가로 축, 세로 축에 대한 이동 영향을 준다.
        // 그런데 이때 좌, 상은 보이지만 우, 하는 잘 모르겠다.
        // 이를 위해 devtool을 열어 guidelines를 켜주면 쉽게 확인 가능하다.
        vertical: 80,
        horizontal: 20,
      ),
      // padding을 강하게 주게 되면 내부 박스가 작아져 글씨가 가려짐을 볼 수 있다.
      padding: EdgeInsets.all(40),
      child: Text('hello'),
    );
  }
}

class Widget_2 extends StatelessWidget {
  const Widget_2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // 이때 Column의 전체 크기를 보면 가로는 child의 크기에 맞지만, 세로는 무한한 것을 볼 수 있다. Center로 감싸일 때 잘 확인할 수 있다.
        // Center로 Column이 감싸일 때, 세로가 무한이기에 중앙 위 부터 차례로 정렬되는 것을 볼 수 있다.
        // 따라서 이를 위해 ainAxisAlignment 속성을 주어야 한다. => mainAxisAlignment: MainAxisAlignment.center

        // 물론 무한한 공간을 부여하지 않게도 할 수 있다.
        // 이때는 최소 공간만 차지하게 된다.
        mainAxisSize: MainAxisSize.min,

        // 다음 속성은 정렬의 순서를 바꿀 수 있다. 밑에서 위 방향으로 쌓인다.
        verticalDirection: VerticalDirection.up,

        //간격을 지정해 줄 수도 있다.
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly는 모든 간격을 동일하게 지정한다.
        //mainAxisAlignment: MainAxisAlignment.spaceBetween은 모든 요소가 극단적인 간격을 가진다.

        // 아래의 지정은 축 끝 정렬이다. 이때 컨테이너의 크기가 다르니 200을 축으로 하여 거기서 정렬된다.
        // 그리고 플러터에서 width나 height의 한계를 넘어서면 자동으로 inf로 바뀌어 창 끝을 기준으로 하게 된다.
        crossAxisAlignment: CrossAxisAlignment.end,

        // 만일 컨테이너를 한 방향으로 채우고 싶다면, crossAxisAlignment: CrossAxisAlignment.stretch를 사용하고 모든 width 값을 지워보자.
        // 물론 row라면 height를 지우면 된다.

        // flexible에 대해 다음 글을 읽어보자. https://devmg.tistory.com/195 매우 유용할 것이다.

        // 여기서 배운 mainAxis와 crossAxis를 잘 활용하자!

        children: [
          Flexible(
            flex: 2,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: Text('Container 1'),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Flexible(
            flex: 3,
            child: Container(
              width: 200,
              height: 100,
              color: Colors.blue,
              child: Text('Container 2'),
            ),
          )
        ],
      ),
    );
  }
}
