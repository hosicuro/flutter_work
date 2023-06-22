import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_chat/image/image.dart';
import 'package:my_chat/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance;
  // 이는 인증의 인스턴스 객체이다.
  bool isSignupScreen = true;
  bool showSpinner = false;
  bool isNameSuccess = true;
  bool isEmailSuccess = true;
  bool isPasswordSuccess = true;
  final _formkey = GlobalKey<FormState>();
  // 이는 전반적인 formstate를 관리해줄 key가 된다.
  // 이는 form 위젯에 저달해준다.

  String userName = '';
  String userEmail = '';
  String userPassword = '';
  File? userPickedImage;
  // 이들은 입력 받은 정보를 보관하게 된다.

  void pickedImage(File image) {
    userPickedImage = image;
    // 해당 함수에 의해 전달 받은 매개변수가 우리의 이미지 저장 변수로 옮겨오게 된다.
    // 이 함수는 바로 아래에서 인자로 전달된다.
    // 즉, 이미지를 담당하는 위젯으로 함수를 전달하여 받아오는 기능을 전달해주는 것이다!
  }

  void _tryValidation() {
    final isValid = _formkey.currentState!.validate(); // <- null check!
    // 이제 formkey를 통해 상태를 불러오고, 모든 하위 validate를 실현시킬 수 있게 된다.
    // 만일 버튼을 눌렀을 때, 유효할 때는 validate가 null을 리턴하게 되기에, 결과를 확인할 수 있다.
    if (isValid) {
      // 따라서 유효하지 않은 값에 대한 validate가 필요하다는 것을 저장하여야 하기에 다음처럼 구성한다.
      _formkey.currentState!.save();
      // 이때 save에 의해 저장됨과 동시에 각 textfield에서 onsaved 메소드를 호출하게 된다. 추가하자.
    }
  }

  void show_popup(BuildContext context) {
    // 위젯 트리 상에 추가되어야 하니 buildcontext가 요구된다.
    showDialog(
      // 이는 팝업 창을 띄워주는 기본 기능이 된다.
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          // 이때 괄호가 없는 것은, 함수의 실행을 요구하기 보다는 본연적인 전달을 위함이다.
          // 물론 기능은 진행된다.
          child: Imageadd(pickedImage),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: ModalProgressHUD(
        // 이는 우리가 true 값을 주면 화면이 돌아가게 된다.
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            // 키보드를 입력하다 빈 곳을 터치하여 내려가도록 만들어주었다.
          },
          child: Stack(
            // 우리는 위젯을 층층히 쌓을 것이다.
            // 원하는 순서를 표현하면서, 원하는 위치에 놓을 수 있다.
            children: [
              // 원하는 위치에 놓기 위해 사용한다. 이는 stack에서 사용된다.
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                // 사진과 텍스트 등의 여러 요소를 넣기 위해 container 사용
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage('image/red.jpg'),
                    //   fit: BoxFit.fill,
                    //   // 이것의 구성은 위의 상단바로 인한 여백을 채워준다.
                    // ),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 90, left: 20),
                    // 이는 텍스트가 생성 즉시, 가장 위에 위치하기에 이를 조정한다.
                    child: Column(
                      // 이는 Column 상에서 좌측에 위치하도록 하였다.
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          // 이는 행 내에서 서로 다른 텍스트를 적용하고자 할 떄 사용된다.
                          // 아래는 글자, 문단을 모아 구성하도록 한다. 즉, 문자에 여러 속성을 줄 때 사용한다.
                          // 그리고 https://velog.io/@steadygo247/FlutterTextTextSpanRichText 처럼 richtext 아래에서 주로 사용된다.
                          text: TextSpan(
                            text: 'Welcome',
                            style: TextStyle(letterSpacing: 1.0, fontSize: 25, color: Colors.white),
                            children: [
                              // 지금 보는 것 처럼, TextSpan은 children으로 TextSpan을 가지기에 서로 다른 변화를 줄 수 있다.
                              TextSpan(
                                text: isSignupScreen ? ' to chat!' : ' back',
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          isSignupScreen ? 'Signup to continue' : 'Signin to continue',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //배경
              AnimatedPositioned(
                // 이는 크기가 변할 때 변화 효과를 주기 위해 지정하였다.
                duration: Duration(milliseconds: 500),
                // 이는 변화의 시간을 결정해준다.
                curve: Curves.easeIn,
                // 이는 애니메이션 효과를 지정해준다.
                top: 180,
                // 이는 내부 컨테이너를 바꾸는 게 아니라 전체 위젯을 바꾸기에 위에 위치한다.
                child: AnimatedContainer(
                  // 또한 내부 컨테이너 또한 변화를 준다.
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  // padding은 내부 간격을 결정한다.
                  padding: EdgeInsets.all(20.0),

                  // 이는 로그인 화면을 담는 컨테이너가 각 상황마다 크기가 달라지게 하였다.
                  height: isSignupScreen ? 280.0 : 250.0,

                  // 아래의 기능은 현재 기기의 width 값을 불러오며 이것에서 40을 빼서 지정하라는 의미이다.
                  // 이건 크기를 지정한 것이고, 아래의 margin을 위해 지정하였다. margin은 바깥 속성을 결정한다.
                  // 이 덕분에 가로로 돌려도 일정한 간격이 지정된다.
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      // 이는 여러 효과가 들어갈 수 있기에 list를 가진다. Opancity는 투명도이다.
                      BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, spreadRadius: 5),
                    ],
                  ),
                  child: SingleChildScrollView(
                    // 과정을 통해 키보드가 올라올 때 내부 영역을 가리지 않도록 스크롤 가능하게 만들어 주었다.
                    padding: EdgeInsets.only(
                      bottom: 20.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // 로그인과 가입 버튼이 가로로 배치되며 서로 끝으로 떨어진다.
                          children: [
                            // 우리가 container가 눌릴 때 변화를 주어야 하니 사용한다.
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignupScreen ? Palette.activeColor : Palette.textColor1,
                                      // 이 기능은 로그인 화면으로 지정 되었을 때 활성도를 바꾸어주려 하였다.
                                    ),
                                  ),
                                  if (!isSignupScreen)
                                    // 상황에 따라 활성도가 다르다.
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'SIGNUP',
                                        style: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.bold, color: isSignupScreen ? Palette.activeColor : Palette.textColor1),
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      if (isSignupScreen)
                                        GestureDetector(
                                          onTap: () {
                                            show_popup(context);
                                          },
                                          child: Icon(
                                            Icons.image,
                                            color: isSignupScreen ? Colors.cyan : Colors.grey[300],
                                          ),
                                        )
                                    ],
                                  ),
                                  if (isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 3, 35, 0),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                        if (isSignupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            // 해당 컨테이너만 margin을 주게 된다.
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  // https://dev-yakuza.posstree.com/ko/flutter/widget/textfield/

                                  // textformfield를 사용하게 되면, 훨씬 편한 텍스트 입력을 만들 수 있게 된다.
                                  // 우리는 이전에 Textform을 사용하였고, 각각의 controller가 필요했다.
                                  // 만일 field가 많아지면 이 방법이 더 유용해진다.
                                  TextFormField(
                                    // TextFormField에서 valuekey가 필요한 이유는 각자의 영역을 구분해준다.
                                    // 만일 이것이 쓰이지 않으면 우리가 로그인에서 입력한 내용이 signin에 남게 되는 등의
                                    // state가 꼬이게 된다. 이는 그걸 구별해주게 된다.
                                    // 즉, 다른 key가 오면 이전 key의 값은 사라진다.

                                    key: ValueKey(1),

                                    validator: (value) {
                                      // 이 기능은 유효성을 검사해준다. 여기에 입력되는 값에 의한 검사이다.
                                      // 아래에서 null check를 해주자.
                                      if (value!.isEmpty || value.length < 4) {
                                        // 이곳에서 리턴은 validation message로 formfield 아래에 적히게 된다.
                                        return "Please enter at least 4 characters";
                                      } else {
                                        return null;
                                      }
                                    },
                                    // 이는 사용자가 입력한 value 값을 저장하게 된다
                                    onSaved: (value) {
                                      userName = value!;
                                    },
                                    onChanged: (value) {
                                      userName = value;
                                    },
                                    // onChanged 함수는 텍스트 필드에서 입력된 값을 전달해준다. setState() {inputText = text;} 처럼 쓰기도 한다.
                                    // 위는 validation을 위해 사용된다.

                                    // 아래의 기능은 예쁘지 않은 필드를 꾸민다.
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.account_circle,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        // 이는 위의 경계를 지정할 때, field를 활성화 하면 사라지는 문제를 해결한다.
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        hintText: 'User name',
                                        hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                    // 이는 필드 내부의 간격을 줄여준다.
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    // 아래는 키보드의 형태를 바꾸어 준다.
                                    keyboardType: TextInputType.emailAddress,
                                    key: ValueKey(2),
                                    validator: (value) {
                                      if (value!.isEmpty || !value.contains('@')) {
                                        return 'Please enter a valid email address.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        hintText: 'email',
                                        hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    // 아래의 기능은 해당 텍스트를 감추어 준다.
                                    obscureText: true,
                                    key: ValueKey(3),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        // 항상 firebase 상의 비밀번호의 길이는 6자리 이하여야 한다.
                                        return 'Password must be at least 7 characters long.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        hintText: 'password',
                                        hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (!isSignupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: ValueKey(4),
                                    validator: (value) {
                                      if (value!.isEmpty || !value.contains('@')) {
                                        return 'Please enter a valid email address.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        hintText: 'email',
                                        hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    key: ValueKey(5),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        return 'Password must be at least 7 characters long.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35.0),
                                          ),
                                        ),
                                        hintText: 'password',
                                        hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  )
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
              //텍스트 폼 필드
              AnimatedPositioned(
                // 버튼은 내부 컨테이너에게 변화를 줄 필요는 없을 것이다.
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                // 이 또한 배경 지정과 같다.
                top: isSignupScreen ? 430 : 390,
                right: 0,
                left: 0,
                // 이런 positioned 위젯은 위치에 따라 공간을 차지한다. 따라서 좌우 지정이 없기에 center 작용을 해야 내부 크기에 맞추어 적용이 된다.
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        // 화면을 다시 갱신하게 될 것이다.
                        showSpinner = true;
                      });
                      if (isSignupScreen) {
                        if (userPickedImage == null) {
                          setState(() {
                            showSpinner = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please pick your image'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                          // 이로 인해 현재 화면을 다시 돌려주게 된다.
                          // 즉, 이미지 등록이 진행되지 않는다면 화면을 고정시킨다.
                          return;
                        }
                        _tryValidation();
                        // 이 기능은 Future를 반환하기에 정해진 변수에 넣고 await를 지정했다.
                        try {
                          final newUser = await _authentication.createUserWithEmailAndPassword(
                            email: userEmail,
                            password: userPassword,
                          );

                          // 아래는 실질적으로 전달이 되지 않는 'userID'를 전달해보고자 한다.
                          // 이를 위해 collection에 먼저 user를 전달하고, 이를 doc 기능을 통해 newUser로 전달할 것이다.
                          // 따라서 여기서 firestore가 사용된 이유가 된다. newUser의 각 유저 uid를 추가하자.
                          // 또한 set으로 값을 전달하게 되며, 데이터는 map 형식임을 기억하자!
                          // 이를 구별하기 위해 email도 함께 전달해 주게 되었다.
                          // 따라서 이제 user가 signup을 진행할 때 이 두 데이터 또한 전달할 수 있게 되었다.
                          // 마지막으로 아래는 future를 전달하니 await를 입력한다.
                          // 데이터 베이스 탭 가장 상위에 user 컬렉션이 등록되며 아래 두 값이 전달되었음을 알게 된다!

                          // 이 기능은 firebasestorage 상의 버킷을 참조할 수 있게 된다.
                          final refImage = FirebaseStorage.instance.ref().child('image').child(newUser.user!.uid + 'png');
                          // 이미지는 고유한 이름을 가져야 하기에 우선은 등록시에만 작용하도록 한다.
                          // 따라서 user uid 정보를 가져와 이를 파일 이름으로 지정하도록 하였다.

                          await refImage.putFile(userPickedImage!);
                          // 이는 해당 파일명에 직접적으로 파일을 전달하게 된다.
                          final file_image = await refImage.getDownloadURL();
                          // 파일은 스토리지 상에서 url로 정보를 담는다. 이를 받아오게 된다. 이는 또한 포인터이다.

                          await FirebaseFirestore.instance.collection('user').doc(newUser.user!.uid).set({
                            'userName': userName,
                            'email': userEmail,
                            'image': file_image,
                            // 이를 통해 우리가 파일을 불러오지 않아도, url만으로 충분한 활용이 가능하다.
                          });

                          if (newUser.user != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return ChatScreen();
                              }),
                            );
                            setState(() {
                              showSpinner = false;
                            });
                          }
                          // 이는 여러 요인으로 오류가 발생할 때를 대비한다.
                        } catch (e) {
                          if (mounted) {
                            // 이 기능을 통해 이미 위젯이 사라졌을 때 호출됨을 방지해준다!
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please check your email and password'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }
                      }
                      if (!isSignupScreen) {
                        _tryValidation();

                        try {
                          final newUser = await _authentication.signInWithEmailAndPassword(
                            email: userEmail,
                            password: userPassword,
                          );
                          if (newUser.user != null) {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return ChatScreen();
                            //     },
                            //   ),
                            // );
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        } catch (e) {
                          print(e);
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      }
                    },
                    child: Container(
                      // 이는 바깥과 안 쪽을 구별하기 위해 사용되었다.
                      padding: EdgeInsets.all(15),
                      height: 90,
                      width: 300,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                      child: Container(
                        decoration: BoxDecoration(
                          // 이는 그라데이션이다.
                          gradient: LinearGradient(colors: [Colors.black, Colors.white], begin: Alignment.topLeft, end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //전송버튼

              // AnimatedPositioned(
              //   duration: Duration(milliseconds: 500),
              //   curve: Curves.easeIn,
              //   // 아래로 인해 현재 기기의 높이를 계산하여 위치 지정을 하고, 좌 우로 넓게 차지한다.
              //   top: isSignupScreen ? MediaQuery.of(context).size.height - 125 : MediaQuery.of(context).size.height - 165,
              //   right: 0,
              //   left: 0,
              //   child: Column(
              //     children: [
              //       Text(isSignupScreen ? 'or Signup with' : 'or Signin with'),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       TextButton.icon(
              //         onPressed: () {},
              //         style: TextButton.styleFrom(
              //             foregroundColor: Colors.white,
              //             minimumSize: Size(155, 40),
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              //             backgroundColor: Palette.googleColor),
              //         icon: Icon(Icons.add),
              //         label: Text('Google'),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
