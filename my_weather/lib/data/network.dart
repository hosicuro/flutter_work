import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  final String url;
  // 생성자를 통해 url을 받고자 한다.
  Network({required this.url});

  Future<dynamic> getJsonData() async {
    // 아래는 uri를 읽어와 response 객체에 저장한다. 이때 get은 http에서 지정된 메소드로 반환이 Future<Response>로 지정된다. <눌러서 알아보자>
    // https://pub.dev/packages/http 사이트 우측의 API reference -> 좌측 http libraries에 들어가면 -> 우리가 사용하는 객체인 response 클래스에 대한 기능이 나와있다.
    // 따라서 print를 response로서 사용하게 된다면 객체 자체에 대한 설명만이 반환된다. 내부 데이터를 활용하기 위해 body 기능을 사용할 것이다.
    // 또한 이렇게 얻어오는 요소는 String으로 온다. 그런데 이때 현재 우리가 참고하는 속성이 json(JavaScript Object Notation) 포맷이기에 map 자료 구조의 형태로 받아온다.
    // json 방식의 특징은 요소를 나타내는 key에 value가 매칭되며, 일부 요소는 value 안에 다시 key:value 속성이 존재한다. 또한 특이하게 weather은 list형태로 되어 원소가 map 형태가 된다.
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // 아래의 과정은 받아온 body를 string 변수에 할당한다. 이후 jsonDecode를 통해 우리가 원하는 요소만 따로 받아올 수 있게 된다.
      // map 자료 구조에 따라 key 값을 다음과 같이 할당하여 사용하며, var이 오는 이유는 오는 요소가 다 타입이 다를 수 있기 때문이다. double, String으로 다양하기 때문이다.
      String jsonData = response.body;
      var passingData = jsonDecode(jsonData);
      // 받아온 데이터를 decode 한 값을 반환하기에 dynamic을 반환한다.
      return passingData;
    } else {
      // if의 과정은 정상적인 신호가 전달되었을 때의 값이다. 즉,
      print(response.statusCode);
    }
  }
}
