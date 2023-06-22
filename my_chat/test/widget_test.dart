import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStorePage extends StatefulWidget {
  const FireStorePage({Key? key}) : super(key: key);

  @override
  State<FireStorePage> createState() => _FireStorePageState();
}

class _FireStorePageState extends State<FireStorePage> {
  // 이제 product에 정보가 담겼고 이를 활용할 수 있게 된다.
  CollectionReference product = FirebaseFirestore.instance.collection('items');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    // 업데이트 기능은 당연히 비동기 방식으로 진행되며, documentSnapshot을 받아온다.

    // 아래의 기능은 텍스트 입력을 위한 기능이다.
    // 현재의 값을 먼저 담게 된다.
    nameController.text = documentSnapshot['name'];
    priceController.text = documentSnapshot['price'];

    await showModalBottomSheet(
      // 이것은 입력값을 받기 위해 입력창이 바닥에서 올라오는 위젯이다.

      // 스크롤 가능하게 만든다.
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        // 여기서 container를 사용할 수 있다. 배경과 효과를 꾸며준다. 리소스를 많이 먹는 특징이 존재한다.
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
              // 이 기능을 사용하면 viewInsets.bottom에 의해 키보드 위에 위치하게 되며,
              // https://m.blog.naver.com/chandong83/221890678439 처럼 MediaQuery는 앱의 크기를 알아낸다.
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이들은 텍스트 입력 필드이다. 자동 지정된다.
                TextField(
                  // 또한 이곳에서 위에 불러왔던 값이 보이는 상태에서 수정이 가능하게 지정된다.
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  // 이 또한 비동기 방식이다.
                  onPressed: () async {
                    // 이후 위쪽 텍스트 필드에서 값이 변하게 되며, 이들이 변수에 담기게 된다.
                    final String name = nameController.text;
                    final String price = priceController.text;

                    await product.doc(documentSnapshot.id).update({"name": name, "price": price});

                    nameController.text = "";
                    priceController.text = "";
                    Navigator.of(context).pop();
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _create() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = nameController.text;
                    final String price = priceController.text;
                    // 이 기능만 위와 달라진다.
                    await product.add({'name': name, 'price': price});

                    nameController.text = "";
                    priceController.text = "";
                    Navigator.of(context).pop();
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(String productId) async {
    // 여기서는 요소 id만 존재하면 된다.
    await product.doc(productId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud Firestore'),
      ),

      // 이곳은 firebase의 데이터를 접근하고 참조하는 기능이다.
      // streambuilder는 Firestore의 정보 변화를 인지하고 알려주게 된다.
      body: StreamBuilder(
        // 이러한 stream을 통해 오는 snapshot은 결과를 담고 있다.
        stream: product.snapshots(),

        // 아래는 실질적인 기능을 하는 builder가 된다.
        // 그리고 stream을 통해 전달된 데이터가 담기는 snapshots를 이용하기 위한
        // 매개변수가 뒤쪽에 오며 이는 QuerySnapshot 타입으로 온다.

        // 따라서 이를 통해 실시간 데이터가 firestore에서 업데이트 되면, 자동으로 불러오게 된다.
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            // 아래의 기능은 데이터가 있다면, 이들을 탐색하여 listview 형태로 표현하게 된다.
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                // 각 요소마다 card 형태의 위젯으로 반환시켜준다.
                return Card(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: ListTile(
                    // 우리는 위에서 'items'라는 콜렉션에 접근하였다.
                    // 이 내부에는 'name', 'price' 문서가 존재하며 이를 접근할 수 있다.
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['price']),

                    // https://velog.io/@sharveka_11/Flutter-4.-ListTile
                    // 이는 title 우측에 요소를 추가한다.
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // 각각 업데이트, 삭제 기능을 담당한다.
                          IconButton(
                            onPressed: () {
                              _update(documentSnapshot);
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              _delete(documentSnapshot.id);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          // 만일 가져온 데이터가 없다면, 로딩 화면을 보여준다.
          return Center(child: CircularProgressIndicator());
        },
      ),
      // 이는 빈 요소에 추가할 수 있도록 해준다.
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          _create();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
