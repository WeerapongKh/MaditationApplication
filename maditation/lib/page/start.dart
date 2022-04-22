import 'package:maditation/timmersettings/countdowntimer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:maditation/page/home.dart';
import 'package:maditation/page/login.dart';
import 'package:maditation/page/profile.dart';
import 'package:maditation/page/settime.dart';
import 'dart:async';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/home.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Positioned(
          bottom: -80,
          left: 68,
          child: SplashScreen(),
        )
      ],
    ));
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ButtomNavigation()));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}

class ButtomNavigation extends StatefulWidget {
  const ButtomNavigation({Key? key}) : super(key: key);

  @override
  _ButtomNavigationState createState() => _ButtomNavigationState();
}

class _ButtomNavigationState extends State<ButtomNavigation> {
  int _currentIndex = 0;
  final tabs = [HomeScreen(), SettimeScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text(
              "หน้าหลัก",
              style: TextStyle(fontFamily: 'NotoSans'),
            ),
            selectedColor: Colors.pink,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.alarm),
            title: Text(
              "ตั้งค่าเวลา",
              style: TextStyle(fontFamily: 'NotoSans'),
            ),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text(
              "ฉัน",
              style: TextStyle(fontFamily: 'NotoSans'),
            ),
            selectedColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
