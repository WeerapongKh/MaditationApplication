import 'package:flutter/material.dart';
import 'package:maditation/page/home.dart';
import 'package:maditation/page/start.dart';
import 'package:maditation/page/profile.dart';
import 'package:maditation/page/settime.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StartScreen());
  }
}
