import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maditation/page/settime.dart';

class Switch_playsound extends StatefulWidget {
  const Switch_playsound({Key? key}) : super(key: key);

  @override
  _Switch_playsoundState createState() => _Switch_playsoundState();
}

class _Switch_playsoundState extends State<Switch_playsound> {
  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      child: CupertinoSwitch(
        value: Selectimer.playsound,
        onChanged: (value) {
          Selectimer.playsound = value;
          setState(() {});
        },
      ),
    );
  }
}
