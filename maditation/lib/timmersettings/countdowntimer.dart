import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:maditation/page/settime.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'package:intl/intl.dart';
import '../database/date_db.dart';
import '../model/date.dart';

class CountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CountDownTimer(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // scaffoldBackgroundColor: const Color.fromRGBO(255, 196, 196, 1),
        accentColor: const Color.fromRGBO(250, 160, 161, 1),
      ),
    );
  }
}

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  double progress = 1.0;
  bool isPlaying = false;
  Duration count = Selectimer.holder;
  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  List<DataModel> data = [];
  late DB db;

  void getdata() async {
    db = DB();
    data = await db.getData();
  }

  static var now = DateTime.now();
  var toShow = now.yearInBuddhistCalendar;
  static var formats = DateFormat.yMMMMEEEEd();
  var toFormats = formats.formatInBuddhistCalendarThai(now);

  final assetsAudioPlayer = AssetsAudioPlayer();
  void _counttime() {
    if (timerString == '0:00') {
      Selectimer.counttime = Selectimer.holder;
      String os = Selectimer.counttime.inMinutes.toString();
      getdata();
      db.insertData(DataModel(day: "${toFormats}", minute: os));
    }
  }

  void _soundBg() {
    if (Selectimer.playsound == true) {
      assetsAudioPlayer.open(
        Audio("assets/audio/soundbg.mp3"),
        autoStart: true,
      );
    }
  }

  void notifyend() {
    if (timerString == '0:00') {
      Selectimer.counttime = Selectimer.holder;
      // db.insertData(
      //     DataModel(day: "${toFormats}", minute: os));
      assetsAudioPlayer.open(
        Audio("assets/audio/assets_audio_gong.mp3"),
      );
    }
  }

  void notifystart() {
    if (Selectimer.playsound != true) {
      assetsAudioPlayer.open(
        Audio("assets/audio/assets_audio_gong.mp3"),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: count,
    );
    controller.addListener(() {
      notifyend();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          _counttime();
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  void dispose() {
    assetsAudioPlayer.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                    animation: controller,
                                    backgroundColor: Colors.white,
                                    color: themeData.indicatorColor,
                                  )),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        timerString,
                                        style: TextStyle(
                                            fontSize: 85,
                                            color: Color.fromARGB(
                                                255, 102, 102, 102)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return Container(
                                padding: const EdgeInsets.all(25.0),
                                child: SizedBox(
                                    height: 50,
                                    width: 150,
                                    child: FloatingActionButton.extended(
                                        foregroundColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        extendedTextStyle: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Notosans',
                                        ),
                                        onPressed: () {
                                          if (controller.isAnimating) {
                                            assetsAudioPlayer.pause();
                                            controller.stop();
                                          } else {
                                            notifystart();
                                            _soundBg();
                                            controller.reverse(
                                                from: controller.value == 0.0
                                                    ? 1.0
                                                    : controller.value);
                                          }
                                        },
                                        icon: Icon(controller.isAnimating
                                            ? Icons.pause
                                            : Icons.play_arrow),
                                        label: Text(controller.isAnimating
                                            ? "หยุด"
                                            : "เริ่ม"))));
                          }),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 13.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
