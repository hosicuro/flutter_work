import 'package:flutter/material.dart';
import 'package:my_ui/Widget/Social_Button.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});
  @override
  State<Login_Screen> createState() => _LoginState();
}

class _LoginState extends State<Login_Screen> {
  // login화면은 text field가 지속적으로 변하고 상태 인식이 필요하기에 stateful 위젯을 이용한다.

  // 아래의 객체는 textfield에 대해 control, 즉 정보를 받아와 조작할 수 있도록 하는 요소이다.
  TextEditingController ID = TextEditingController();
  TextEditingController PW = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Login'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: GestureDetector(
        // 움직임을 감지한다. 이는 페이지 전체에 걸치기에 가장 상위 위젯으로 위치하였다.
        // onpressed는 보통 버튼 입력에 많이 쓰인다. ontap은 길게 누르기, 두 번 누르기 등의 요소를 담당할 수 있기 때문이다.
        onTap: () {
          // FocusNode는 focus를 받는 특정 위젯을 식별하도록 한다.
          // FocusScope는 focus를 받을 범위를 지정해준다.

          // 이때 아래의 명령은 focus를 받는 요소 전체를 인식하게 되며, unfocus를 통해 현재 focus를 없애버릴 수 있다.
          // 따라서 이를 통해 focus된 키보드 입력을 없애게 된다. 그 과정에서 onTap, 즉 바깥 요소를 누르면 작동하게 된다.
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          // 이는 페이지 스크롤이 가능하도록 하였다. 움직임 감지 하위요소들의 가장 상위 요소에 위치하였다.
          // 키보드가 올라왔을 때 우리가 방해받지 않기 위해 넣어주었다.
          child: Padding(
            // 전체 요소들에 대한 가로, 세로 padding을 넣어주었다.
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 40.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 이는 보통 text field의 나열과 사용을 위해 사용되는 요소이다.
                // 즉, 정보 입력 양식을 지정한다.
                Form(
                    child: Theme(
                        // 위젯의 테마를 결정한다.
                        data: ThemeData(
                            // 이는 테마의 요소들을 결정한다.
                            primaryColor: Colors.amber,
                            // 이는 우리가 text 입력란에 보면 입력 바 색상을 결정한다.
                            inputDecorationTheme: InputDecorationTheme(
                                // 여기에 위치한 요소는 우리가 text 입력에 참고하는 label에 대한 요소를 결정해준다.
                                labelStyle: TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 15.0,
                            ))),
                        child: Column(
                          children: [
                            // text를 입력하게 하는 textfield를 꾸며준다.
                            TextField(
                              // 위에서 설명한 것 처럼, focus는 어떤 요소에 집중하도록 만든다.
                              // 따라서 아래의 기능은 앱이 시작될 때 첫 텍스트 필드를 클릭한 것처럼 키보드가 올라오고 입력 대기가 된다.
                              // autofocus: true,
                              controller: ID,
                              decoration: InputDecoration(labelText: 'Input ID'),
                              // 이는 keyboard의 속성, 예를 들어 이메일 입력이면 이메일 관련 특수문자를 키보드에 표시해준다.
                              keyboardType: TextInputType.text,
                            ),
                            TextField(
                              controller: PW,
                              decoration: InputDecoration(labelText: 'Input PW'),
                              keyboardType: TextInputType.text,
                              // 아래의 요소는 text를 암호화 하여 가려준다.
                              obscureText: true,
                            ),
                          ],
                        ))),
                SizedBox(
                  height: 100.0,
                ),
                Social_Button(
                  color: Colors.white,
                  image: Image.asset('assets/glogo.png'),
                  text: Text(
                    'Login to Google',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Social_Button(
                  color: Colors.indigo,
                  image: Image.asset('assets/flogo.png'),
                  text: Text(
                    'Login to Facebook',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (ID.text == 'ID' && PW.text == 'PW') {
                      Navigator.pop(context);
                    } else if (!(ID.text == 'ID' && PW.text == 'PW')) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Is correct?',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.grey,
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lime,
                    minimumSize: Size(100.0, 50.0),
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 40.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
