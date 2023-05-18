import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  // 이는 위젯의 상황이 변경될 때 마다, 자동으로 호출되는 build 메서드가 된다.
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 이 기능은 appbar 우측 위 debug 표시를 지워준다.
      title: 'HOSI',
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 이것은 앱 화면의 배경을 결정한다.
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: Text('PROFILE'),
        //backgroundColor: Colors.purpleAccent[100],
        centerTitle: true,
        elevation: 2.0,
      ),
      body: Mymain(),
    );
  }
}

class Mymain extends StatelessWidget {
  Mymain({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 40.0),
      // 위젯의 padding을 좌, 우 30을 주었다. 모든 요소를 고르게 정렬한다.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // 현재 축은 padding의 영향을 받은 x=30의 세로 선이다.
        // 이에 따라 세로 선을 기준으로 좌측 정렬이 된다.
        // 이때 Column의 영향을 받는 모든 요소에 적용이니 위치는 이곳이 된다.
        children: [
          // 위젯의 기능을 알아볼때는 ctrl + space를 이용하자!
          // 아래 위젯은 이미지를 추가하는 위젯이다. 이때 이를 중앙에 정렬하기 위해
          // CircleAvatar을 블록 처리한 후 좌측 전구를 클릭하여 정렬 기능을 자동 삽입 하였다.

          // 특히 crossAxisAlignment는 Column이나 Row 아래의 모든 요소에 해당할 때 사용하니
          // 우리가 개별 요소를 정렬하려면 Center 위젯 내부에 넣어야 한다!!

          // 또는 다른 방법으로 CircleAvatar을 아예 Padding 밖으로 뺀 후에
          // Center와 Column을 다시 적용해주는 방법도 있다.

          Center(
            child: CircleAvatar(
              // 이미지를 원형의 위젯으로 만들어준다.
              backgroundImage: AssetImage('assets/frodo.png'),
              radius: 60.0,
            ),
          ),
          Divider(
            height: 60.0,
            // 이는 위, 아래 위젯과의 간격을 주는 선을 삽입한다.
            color: Colors.grey[850],
            thickness: 0.5,
            // 아래는 우리가 만일 padding의 우측 indent를 주지 않았다면 사용해야 했다.
            //endIndent: 30.0,
          ),
          Text(
            'NAME',
            style: TextStyle(
              // control + 마우스를 가져다 대면 이 클래스에 대한 메서드를 볼 수 있다.
              color: Colors.white,
              // 이 기능은 텍스트 글자 간의 간격을 지정한다.
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(
            // 이 기능은 children의 요소로서, 여기서는 text 사이에 위치한다.
            // 이는 가로, 세로의 요소를 지닌 unvisible box가 되며, 일반적으로 text 사이 간격을 위해 사용된다.
            height: 10.0,
          ),
          Text(
            'HOSI',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2.0,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'AGE',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '21',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2.0,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              Icon(Icons.check_circle_outline),
              SizedBox(
                // 이는 가로 간격이니 width를 사용한다.
                width: 10.0,
              ),
              Text(
                'have smart_phone!',
                style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Icon(Icons.check_circle_outline),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'have credit_card!',
                style: TextStyle(fontSize: 16.0, letterSpacing: 1.0),
              ),
            ],
          ),
          SizedBox(
            height: 70.0,
            // 이 기능은 indent, 즉 초반에 우리가 지정한 padding을 무시한다.
          ),
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/pengin.gif'),
              radius: 45.0,
              backgroundColor: Colors.pink[100],
              // 그림의 배경이 투명 배경일 때 배경을 지정할 수 있다.
            ),
          )
        ],
      ),
    );
  }
}
