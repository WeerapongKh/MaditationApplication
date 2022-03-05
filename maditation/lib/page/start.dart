import 'package:maditation/timmersettings/countdowntimer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:maditation/pages/home.dart';
import 'package:maditation/pages/login.dart';
import 'package:maditation/pages/profile.dart';
import 'package:maditation/pages/settime.dart';

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
          child: Button(),
        )
      ],
    ));
  }
}

class Button extends StatefulWidget {
  const Button({Key? key}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

//ส่วนของปุ่ม------------------------------------------------
class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return new IconButton(
        icon: Image.asset('assets/images/Button-start.png'),
        iconSize: 250,
        // Within the `FirstRoute` widget
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ButtomNavigation()),
          );
        });
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
