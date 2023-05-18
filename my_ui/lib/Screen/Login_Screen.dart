import 'package:flutter/material.dart';
import 'package:my_ui/Widget/Social_Button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});
  @override
  State<Login_Screen> createState() => _LoginState();
}

class _LoginState extends State<Login_Screen> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller_1 = TextEditingController();

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
        onTap: () {
          // 이는 focus가 아닌, 즉 textfield나 keyboard 입력이 아닌 요소들을 감지한다.
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 40.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 이는 text field에 사용된다.
                Form(
                    child: Theme(
                        data: ThemeData(
                            primaryColor: Colors.amber,
                            // 이는 text를 입력하는 label을 꾸미기 위함이다.
                            inputDecorationTheme: InputDecorationTheme(
                                labelStyle: TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 15.0,
                            ))),
                        child: Container(
                          child: Column(
                            children: [
                              // text를 입력하게 하는 텍스트와 field 전체를 꾸며준다.
                              TextField(
                                controller: controller,
                                decoration: InputDecoration(labelText: 'Input ID'),
                                // 이는 keyboard의 속성, 예를 들어 이메일 입력이면 이메일 관련 특수문자를 키보드에 표시해준다.
                                keyboardType: TextInputType.text,
                              ),
                              TextField(
                                controller: controller_1,
                                decoration: InputDecoration(labelText: 'Input PW'),
                                // 이는 keyboard의 속성, 예를 들어 이메일 입력이면 이메일 관련 특수문자를 키보드에 표시해준다.
                                keyboardType: TextInputType.text,
                                obscureText: true,
                              ),
                            ],
                          ),
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
                    if (controller.text == 'ID' && controller_1.text == 'PW') {
                      flutterToast('succeed login!');
                      Navigator.pop(context);
                    } else if (!(controller.text == 'ID' && controller_1.text == 'PW')) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Is correct?'),
                        duration: Duration(seconds: 5),
                        backgroundColor: Colors.grey,
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lime,
                    fixedSize: Size(100, 50),
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

void flutterToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    //backgroundColor: Colors.red,
    fontSize: 20.0,
    //textColor: Colors.red,
    toastLength: Toast.LENGTH_SHORT,
  );
}
