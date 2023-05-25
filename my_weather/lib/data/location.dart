import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getLoacation() async {
    // loadin.dart에서 await으로 값을 받아오기 때문에 future를 반환해주어야 한다.
    LocationPermission permission = await Geolocator.requestPermission();
    // 위의 기능은 위치 권한을 받아오기 위해 필요해진 권한이다.
    try {
      // 만일 아래의 코드에서 await를 쓰지 않고, 그냥 Future를 사용하면 아래 코드가 실행된 후 지금 코드가 실행되기에 순차적 오류가 생긴다.
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      // 비 동기적으로 나의 정보를 얻어오게 되며, 이 동안 기다리게 된다. 우측의 accuracy는 정확도의 정도를 나타낸다.
      // 아래의 try-catch 구문은 올바르게 get이 이루어지지 않았을 때 발생하는 예외에 대한 처리이다.
    } catch (e) {
      print('location error!');
    }
  }
}
