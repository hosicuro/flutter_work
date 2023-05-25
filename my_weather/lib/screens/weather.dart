import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({super.key, required this.parseWeatherData});
  // 우리는 loading의 페이지에서 로딩이 끝난 데이터를 weather screen으로 전달하고 싶기에
  // loading을 불러올 때 생성자를 통해 데이터를 받아오고자 한다.
  // 이를 위해 가장 위 클래스에 지정해주었고 <stateful widget이기에>
  // 아래의 변수 지정은 타입 지정이 없다면 자동으로 dynamic으로 지정된다.
  final dynamic parseWeatherData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? cityName;
  int? temp;
  @override
  void initState() {
    super.initState();
    // 우리가 받아온 데이터를 부모 클래스인 위젯을 widget이 모두 받게 되니 이렇게 호출할 수 있게 된다.
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic weatherData) {
    // 이 함수는 전역적인 변수에 전달받은 객체를 이용하여 값을 할당해준다. <업데이트>
    double temp_dou = weatherData['main']['temp'];
    // 정수로 보이기 위해 반 올림 해주었다.
    temp = temp_dou.round();
    // 이 온도를 수정하여 받아올 수도 있다. 사이트 내부에서 아까 api 설명 우측에 units of measurement로 가면 api key에 값을 추가할 수 있다.
    cityName = weatherData['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$cityName',
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '$temp',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
