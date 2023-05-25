import 'dart:io';

void main() {
  showData();
}

void showData() async {
  // 이 함수에서도 await가 함께 쓰이고 있기에 붙여준다.
  startTask();
  String? account = await accessData();
  // 직접적으로 매개변수로 들어가야 하니 !를 붙여준다.
  fetctData(account!);
}

void startTask() {
  String info1 = '요청 수행 시작';
  print(info1);
}

Future<String?> accessData() async {
  String? account;
  Duration time = Duration(seconds: 3);

  //sleep(time);
  // sleep의 기능은 동기적으로 진행된다. 즉, accessData가 쉴 동안 나머지는 기다린다.

  // Future.delayed는 비동기적으로 진행된다. 즉, accessData가 3초간 멈춘 동안 fetchData가 진행된다.

  // 그런데 만약 우리가 데이터를 전달해 주어야 하는데, 3초를 기다려야 정보를 받아와서 전달할 수 있다면 어떨까?
  // 이를 위해 await를 붙여 3초간 반드시 해당 명령을 기다리도록 만들어준다.
  // 이를 위해 함수의 반환 타입은 future 즉, 반드시 후에 정보가 들어오게 된다는 의미가 되며, await를 비동기적으로 처리함을 알리기 위해 async를 붙였다.
  // 추가적으로 변수가 할당되지 않기에 ?를 붙여주었다. <final은 생성자와 함께 쓰여야 한다.>
  await Future.delayed(time, () {
    account = '8,500';
    print(account);
  });

  return account;
}

void fetctData(String account) {
  String info3 = '잔액은 $account원 입니다';
  print(info3);
}
