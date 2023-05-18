import 'package:flutter/material.dart';

class Box {
  final IconData icon;
  final String name;

  Box({required this.icon, required this.name});
}

class MyBox extends StatelessWidget {
  final Box box;
  final Function delete;
  MyBox({super.key, required this.box, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(box.icon),
                Text(
                  box.name,
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton.icon(
              onPressed: () {
                delete();
              },
              icon: Icon(Icons.delete),
              label: Text(
                'delete!',
                style: TextStyle(fontSize: 15.0),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  fixedSize: Size(120, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
