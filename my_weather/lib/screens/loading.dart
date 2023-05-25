import 'package:flutter/material.dart';
import 'package:my_weather/data/location.dart';
import 'package:my_weather/data/network.dart';
import 'package:my_weather/screens/weather.dart';

const apikey = '46c47918f4e6c19f42539bfdd2e5e748';

// 우리는 버튼을 눌렀을 때 나의 위치를 받아오기 위한 package 파일을 설치할 수 있다.
// https://pub.dev/packages/geolocator
// 링크로 들어가 설치 방법을 알고, 문서의 API 탭으로 이동하여 객체 선언 방법을 볼 수 있다.
// 외부 요소와 연결을 지어주어야 하기에 API를 이용하게 된다.
// 또한 Gps를 사용하기에 권한을 주어야 한다. 문서의 usage 항목에 들어가서 권한을 주도록 하자!
// 또한 에뮬레이터 설정 상으로 위치와 시간대를 조정해 줄 수 있어야 하기도 한다.
// 사용 예시 또한 이곳에 존재한다.

// 이후 우리가 웹 상에터 json으로 정보를 가져올 것이기에 http package를 설치해준다.
// 또한 사용법을 알기 위해 flutter 공식 문서로 가보았다. https://docs.flutter.dev/cookbook/networking/fetch-data
// gps와 마찬가지로, androidmanifest.xml의 값을 수정해준다. -> 권한 허용 작업이다.

class loading extends StatefulWidget {
  const loading({super.key});

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  double? latitude;
  double? longitude;

  void initState() {
    // 우리가 보통 날씨 앱 실행시에 위치 정보와 정보 적용이 이루어지기에 initstate에서 사용되도록 하였다.
    super.initState();
    getData();
  }

  void getData() async {
    Location location = Location();
    // 값을 받아올 때 까지 기다려야 하기 때문에 await를 사용하였다.
    await location.getLoacation();
    latitude = location.latitude;
    longitude = location.longitude;
    print(latitude);
    print(longitude);

    // 직접적인 날씨 api를 가져오기 위해 https://openweathermap.org/로 들어가서 api를 얻고 사용하자.
    // api -> current weather data -> api doc에 들어가면 우리는 좌표를 이용하기에 by geographic ~ 사용법을 알자.
    // api-key가 필요해진다. 가입하고 api key를 얻자.
    // 이제 우리가 지정한 좌표에 대한 정보를 가져오게 될 것이다.
    Network network = Network(url: 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');

    var weatherData = await network.getJsonData();
    //Navigator.pushNamed(context, 'w'); <- 이 방식을 사용하기에는 매개변수를 전달할 수 없다.
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(
        parseWeatherData: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: null,
          child: Text('Get my location'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
