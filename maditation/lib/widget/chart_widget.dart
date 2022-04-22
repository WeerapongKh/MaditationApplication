import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:maditation/database/date_db.dart';
import 'package:maditation/model/date.dart';
import 'package:maditation/page/profile.dart';

class BarChartSample1 extends StatefulWidget {
  const BarChartSample1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = Color.fromARGB(248, 245, 247, 248);
  final Duration animDuration = const Duration(milliseconds: 250);

  List<DataModel> data = [];
  late DataModel datas;
  int countNum = 0;
  int timeCount = 0;
  int timeSunn = 0;
  int timeMonn = 0;
  int timeTuee = 0;
  int timeWedd = 0;
  int timeThuu = 0;
  int timeFrii = 0;
  int timeSatt = 0;
  //int sumTimes = 0;

  bool fetching = true;
  late DB db;

  @override
  void initState() {
    super.initState();
    db = DB();
    getData2();
    countTotal();
  }

  void getData2() async {
    data = await db.getData();
  }

  void countTotal() async {
    int? totalSum = await db.countDay();
    if (mounted) {
      setState(() {
        countNum = totalSum!;
        //findWord();
        timeSunn = setTimeTocharts.timeOfSunTochart;
        timeMonn = setTimeTocharts.timeOfMonTochart;
        timeTuee = setTimeTocharts.timeOfTueTochart;
        timeWedd = setTimeTocharts.timeOfWedTochart;
        timeThuu = setTimeTocharts.timeOfThuTochart;
        timeFrii = setTimeTocharts.timeOfFriTochart;
        timeSatt = setTimeTocharts.timeOfSatTochart;

        //print(setTimeTocharts.timeOfTueTochart);
      });
    }
  }

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Color.fromARGB(248, 245, 247, 248),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        //isPlaying ? randomData() :
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  findWord() {
    String aa;
    int timeSun = 0;
    int timeMon = 0;
    int timeTue = 0;
    int timeWed = 0;
    int timeThu = 0;
    int timeFri = 0;
    int timeSat = 0;

    for (int i = 0; i < countNum; i++) {
      aa = data[i].day;
      if (aa.contains('วันเสาร์')) {
        timeSat += int.parse(data[i].minute);
      } else if (aa.contains('วันจันทร์')) {
        timeMon += int.parse(data[i].minute);
      } else if (aa.contains('วันอังคาร')) {
        timeTue += int.parse(data[i].minute);
      } else if (aa.contains('วันพุธ')) {
        timeWed += int.parse(data[i].minute);
      } else if (aa.contains('วันพฤหัสบดี')) {
        timeThu += int.parse(data[i].minute);
      } else if (aa.contains('วันศุกร์')) {
        timeFri += int.parse(data[i].minute);
      } else if (aa.contains('วันอาทิตย์')) {
        timeSun += int.parse(data[i].minute);
      }
    }

    // int sumTimes =
    //     ((timeSun + timeMon + timeTue + timeWed + timeFri + timeSat) / 7)
    //         .toInt();
    // print("วันอาทิตย์ ในสัปดาห์นี้ใช้เวลาทั้งหมด $timeSun  นาที");
    // print("วันจันทร์ ในสัปดาห์นี้ใช้เวลาทั้งหมด $timeMon  นาที");
    // print("วันอังคาร ในสัปดาห์นี้ใช้เวลาทั้งหมด $timeTue  นาที");
    // print("วันพุธ ในสัปดาห์นี้ใช้เวลาทั้งหมด $timeWed  นาที");
    // print("วันพฤหัสบดี ในสัปดาห์นี้ใช้เวลาทั้งหมด $timeThu  นาที");
    // print("วันศุกร์ ในสัปดาห์นี้ใช้เวลาทั้งหมด $timeFri  นาที");
    // print("วันเสาร์ ในสัปดาห์นี้ใช้เวลาทั้งหมด $timeSat  นาที");

    // print("เฉลี่ยเวลาในสัปดาห์นี้รวม $sumTimes  นาที");

    setState(() {
      //sumTimes = sumTimes;
      timeSatt = timeSat;
      timeFrii = timeFri;
      timeThuu = timeThu;
      timeWedd = timeWed;
      timeMonn = timeMon;
      timeSunn = timeSun;
      timeTuee = timeTue;
    });
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.pink,
    double width = 15,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow, width: 1)
              : const BorderSide(
                  color: Color.fromARGB(248, 245, 247, 248), width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 70,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, timeMonn.toDouble(),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, timeTuee.toDouble(),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, timeWedd.toDouble(),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, timeThuu.toDouble(),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, timeFrii.toDouble(),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, timeSatt.toDouble(),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, timeSunn.toDouble(),
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'จันทร์';
                  break;
                case 1:
                  weekDay = 'อังคาร';
                  break;
                case 2:
                  weekDay = 'พุธ';
                  break;
                case 3:
                  weekDay = 'พฤหัสบดี';
                  break;
                case 4:
                  weekDay = 'ศุกร์';
                  break;
                case 5:
                  weekDay = 'เสาร์';
                  break;
                case 6:
                  weekDay = 'อาทิตย์';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toInt().toString() + " นาที ",
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromARGB(255, 75, 75, 75),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('จ.', style: style);
        break;
      case 1:
        text = const Text('อ.', style: style);
        break;
      case 2:
        text = const Text('พ.', style: style);
        break;
      case 3:
        text = const Text('พฤ.', style: style);
        break;
      case 4:
        text = const Text('ศุ.', style: style);
        break;
      case 5:
        text = const Text('ส.', style: style);
        break;
      case 6:
        text = const Text('อา.', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return Padding(padding: const EdgeInsets.only(top: 16), child: text);
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}
