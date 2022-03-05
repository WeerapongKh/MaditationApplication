import 'package:flutter/material.dart';

//ข้อแนะนำในการนั่งสมาธิ
class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/detaill.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ));
  }
}
