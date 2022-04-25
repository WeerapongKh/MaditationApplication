// ignore_for_file: deprecated_member_use
import 'package:maditation/database/date_db.dart';
import 'package:intl/intl.dart';
import 'package:maditation/model/date.dart';
import 'package:maditation/timmersettings/countdowntimer.dart';
import 'package:maditation/timmersettings/settings_card.dart';
import 'package:maditation/timmersettings/settings_provider.dart';
import 'package:maditation/timmersettings/switch.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:maditation/timmersettings/perset_timers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maditation/timmersettings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';

class SettimeScreen extends StatelessWidget {
  SettimeScreen({Key? key}) : super(key: key);

  List<DataModel> data = [];

  late DB db;

  String os = Selectimer.counttime.inMinutes.toString();
  void getdata() async {
    db = DB();
    data = await db.getData();
  }

  static var now = DateTime.now();
  var toShow = now.yearInBuddhistCalendar;
  static var formats = DateFormat.yMMMMEEEEd();
  var toFormats = formats.formatInBuddhistCalendarThai(now);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 160, 161, 1),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Image.asset("assets/images/settime-page.png"),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  children: <Widget>[
                    SettingsCard(
                      start: true,
                      title: Text(
                        "จำนวนเวลา",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Notosans',
                        ),
                      ),
                      leading: Icon(Icons.hourglass_empty_sharp),
                      trailing: DropdownIssue(),
                    ),
                    SettingsCard(
                      end: true,
                      title: Text(
                        "เล่นเพลง",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Notosans',
                        ),
                      ),
                      leading: Icon(Icons.music_note),
                      trailing: Switch_playsound(),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Flexible(
                      flex: 3,
                      child: IconButton(
                          icon: Image.asset(
                              'assets/images/Button - Get Started.png'),
                          iconSize: 250,
                          // Within the `FirstRoute` widget
                          onPressed: () {
                            //getdata();
                            // db.insertData(
                            //     DataModel(day: "${toFormats}", minute: os));
                            //  print(toFormats);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountScreen()),
                            );
                          }),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DropdownIssue extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DropdownIssueState();
  }
}

class _DropdownIssueState extends State<DropdownIssue> {
  int currentValue = 5;
  Duration dropdownValue = Duration(minutes: 5);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton<Duration>(
            value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            elevation: 16,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            underline: Container(),
            onChanged: (Duration? newValue) {
              setState(() {
                dropdownValue = newValue!;
                Selectimer.holder = dropdownValue;
              });
            },
            items: kPresetTimers.map((preset) {
              return DropdownMenuItem<Duration>(
                value: preset,
                child: Text(
                  preset.inMinutes.toString() + " นาที",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Notosans',
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class Selectimer {
  static late Duration holder = Duration(minutes: 5);
  static bool playsound = true;
  static late Duration counttime = Duration(minutes: 5);
  static late int oa = 0;
}
