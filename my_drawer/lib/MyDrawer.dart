import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // 기본적으로 drawer 위젯은 자동적으로 아이콘과 drawer 페이지, 스와이프 모션까지 제공한다.

      // listview는 가장 일반적으로 사용되는 스크롤 위젯이다.
      // 이때 listview.builder를 사용하면 크기를 입력받아 동적인 호출이 가능하다.
      // 이는 위젯이기에, body에 바로 위젯으로 들어갈 수 있다.
      // 그런데 Column의 child로는 불가능하다. column의 높이는 무한 listview는 자신의 최대 공간을 사용하기 때문이다.
      // 이를 위해서는 Expanded로 크기 조정을 해줄 수 있다.

      // listview는 children 속성을 통해 하위 요소들을 list의 형식으로 행으로 나열하게 된다.
      // 따라서 Listview, column, drawer, card와도 함께 쓰인다.
      // 이런 하위 요소들은 각각 ListTile으로 붏리며 여러 요소를 넣을 수 있다. (이미지, title, button 등)
      // ListTIle은 column에 비해 list 형식을 지니기에 list<type>(변수명) = [요소들...]인 형식을 취할 수 있다.

      child: ListView(
        padding: EdgeInsets.zero,
        // 우리는 메뉴 바에서 요소들의 여백이 필요 없으니 주지 않을 것이다.
        children: [
          // UserAccountsDrawerHeader는 유저의 정보를 drawer에 표시할 때 사용된다.
          // DrawerHeader는 가장 기본이 되는 형태이다.
          UserAccountsDrawerHeader(
            // 우리가 이 위젯의 요소를 찾아보면, 이름과 이메일에 required가 있음을 확인할 수 있다.
            // 이는 User의 정보를 담는 위젯이니 이 요소들을 반드시 요구하게 된다.
            // 또한 이는 sizedbox 위젯으로 위치의 조절이 가능하다!

            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/lion.png'),
            ),
            otherAccountsPictures: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/apeach.png'),
              ),
              // CircleAvatar(
              //   backgroundImage: AssetImage('assets/frodo.png'),
              // )
            ],
            accountName: Text('HOSI'),
            accountEmail: Text('hosicuro@g.skku.edu'),
            onDetailsPressed: () {
              // 이 버튼은 확장 버튼이므로 기능이 들어간다.
            },
            decoration: BoxDecoration(
                // 이런 drawerheader는 box의 형태이다. 이를 꾸며주자.
                color: Colors.red[200],
                borderRadius: BorderRadius.only(
                    // 이 명령은 경계에 곡면을 처리하는 방법이다.
                    // 여러 방법으로 적용가능하며 only 명령은 특정 부분만 넣을 수 있게 된다.
                    // https://flamingotiger.github.io/frontend/flutter/flutter-style/
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0))),
          ),
          ListTile(
            // 좌측 상단부터 시작하여 일정 간격에 맞추어 icon과 text를 열로 나열하게 된다.
            leading: Icon(
              Icons.home,
              color: Colors.grey[850],
            ),
            title: Text('home'),
            onTap: () {
              // onTap의 기능은 기본적으로 스플래시 액션 기능이 바탕이 된다.
              // 이는 onpressed와는 달리 길게 누르거나, 두 번 탭 할 경우에 사용되는 액션이다.
            },
            trailing: Icon(Icons.arrow_drop_down_circle_rounded),
          ),
          ListTile(
            leading: Icon(
              // https://fonts.google.com/icons <icon을 찾으러 가자!>
              Icons.settings,
              color: Colors.grey[850],
            ),
            title: Text('Fixing'),
            onTap: () {},
            trailing: Icon(Icons.arrow_drop_down_circle_rounded),
          ),
        ],
      ),
    );
  }
}
