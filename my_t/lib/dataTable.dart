import 'package:flutter/material.dart';
import 'package:my_t/source.dart';

class dataTable extends StatefulWidget {
  const dataTable({super.key});

  @override
  State<dataTable> createState() => _dataTableState();
}

class _dataTableState extends State<dataTable> {
  var apikey = "58%2FAb40DJd41UCVYmCZM89EUoOWqT0vuObbReDQCI6ufjHIJbhZOUtQnftZErMQf6%2FgEflZVctg97VfdvvtmQw%3D%3D";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var pageNo = "1";
    var numOfRows = "10";
    var baseDate = "20230621";
    var baseTime = "0600";
    var nx = "55";
    var ny = "127";

    Source source = Source(
        baseUrl:
            "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=$apikey&numOfRows=$numOfRows&pageNo=$pageNo&base_date=$baseDate&base_time=$baseTime&nx=$nx&ny=$ny");

    final weatherData = await source.getJsonData();

    var totalcount = weatherData['response']['body']['pageNo'];
    var basedate = weatherData['response']['body']['items']['item'][5]['baseDate'];
    var basetime = weatherData['response']['body']['items']['item'][5]['baseTime'];
    var obsrvalue = weatherData['response']['body']['items']['item'][5]['obsrValue'];

    print(totalcount);
    print(basedate);
    print(basetime);
    print(obsrvalue);
  }

  final List<List<String>> tableData = [
    ['Cell 1', 'Cell 2'],
    ['Cell 3', 'Cell 4'],
    ['Cell 5', 'Cell 6'],
    ['Cell 7', 'Cell 8'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            '육류등록',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        foregroundColor: Colors.black,
        leading: ElevatedButton(
          onPressed: () {},
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {},
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0.0,
              )),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Text(
            '이력번호 입력',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: View(tableData: tableData)),
        ],
      ),
    );
  }
}

class View extends StatelessWidget {
  const View({
    super.key,
    required this.tableData,
  });

  final List<List<String>> tableData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tableData.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Text(tableData[index][0]),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Text(tableData[index][1]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
