import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:maditation/database/date_db.dart';
import 'package:maditation/model/daily_stat_ui_model.dart';
import 'package:maditation/model/date.dart';
import 'package:maditation/model/user.dart';
import 'package:maditation/page/editProfile.dart';
import 'package:maditation/page/gard_test.dart';
import 'package:maditation/page/settime.dart';
import 'package:maditation/stat_controller.dart';
import 'package:maditation/utils/user_preferences.dart';
import 'package:maditation/widget/buttom_widget.dart';
import 'package:maditation/widget/chart_widget.dart';
import 'package:maditation/widget/profile_widget.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var statController = Get.put(StatController());

  List<DataModel> data = [];
  late DataModel datas;
  int countNum = 0;
  int timeCount = 0;
  int timeSun = 0;
  int timeMon = 0;
  int timeTue = 0;
  int timeWed = 0;
  int timeThu = 0;
  int timeFrii = 0;
  int timeSat = 0;
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
    setState(() {
      fetching = false;
    });

    sumTime();
    textTime(times);
  }

  void countTotal() async {
    int? totalSum = await db.countDay();

    // print("totalSum is $totalSum");

    setState(() {
      countNum = totalSum!;
    });
    //findWord();
  }

  int os = Selectimer.oa;
  var now = DateTime.now();
  var formats = DateFormat.EEEE();
  int times = 0;
  String dateTime = "";

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          //backgroundColor: Colors.pink.shade300,
          //appBar: buildAppbar(context),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 25,
              ),
              ProfileWidget(
                imagePath: user.imagePath,
                onClicked: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()),
                  );
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 24,
              ),
              buildName(user),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: buildUpgradeButtom(),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ss(),
              ),

              //_pageIndicatorText(),

              const SizedBox(
                height: 5,
              ),
              // Text("กดไป $countNum ครั้ง "),
              // Center(
              //   child: Text(
              //     'วันนี้${formats.format(now)}',
              //     style: const TextStyle(fontSize: 20),
              //   ),
              // ),

              //plusebutton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )
        ],
      );

  Widget buildUpgradeButtom() => ButtomWidget(
        text: 'อัปเดตโปรไฟล์',
        onClicked: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
          );
          setState(() {});
        },
      );

  Widget ss() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          //color: Colors.pink.shade50,
          child: Column(
            children: <Widget>[
              Card(
                color: Color.fromARGB(248, 245, 247, 248),
                child: ListTile(
                  title: const Text(
                    "การนั่งสมาธิ",
                    style: TextStyle(fontSize: 17),
                  ),
                  subtitle: Text(
                    dateTime,
                    style: const TextStyle(fontSize: 18),
                  ),
                  leading: const ImageIcon(
                    AssetImage("assets/images/iconM.png"),
                    size: 40,
                  ),
                ),
              ),
              currenWeek(),
              charts(),
            ],
          ),
        ),
      );

  Widget plusebutton() => ButtomWidget(
        text: 'ประวัติการนั่งสมาธิ',
        onClicked: () {
          // db.insertData(DataModel(
          //     day: "${formats.format(now)}",
          //     minute: os));
          // Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
      );

  sumTime() {
    int ss = 0;
    for (var i = 0; i < data.length; i++) {
      ss += int.parse(data[i].minute);
    }

    setState(() {
      times = ss;
    });
  }

  textTime(int time) {
    String timeodd = " ";
    int h = (time ~/ 60);
    int n = (time % 60);

    if (time > 60) {
      timeodd =
          'เวลาที่นั่งทั้งหมด ${h.toString()} ชั่วโมง ${n.toString()} นาที';
    } else {
      timeodd = ' เวลาที่นั่งทั้งหมด   ${time.toString()} นาที';
    }

    setState(() {
      dateTime = timeodd;
    });
  }

  Widget charts() => Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: const [
            BarChartSample1(),
          ],
          //CalendarWidget()
          //BarChartSample3()
        ),
      );

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
        //print("$i.วันเสาร์");
        timeSat += int.parse(data[i].minute);
      } else if (aa.contains('วันจันทร์')) {
        //print("$i.วันจันทร์");
        timeMon += int.parse(data[i].minute);
      } else if (aa.contains('วันอังคาร')) {
        //print("$i.วันอังคาร");
        timeTue += int.parse(data[i].minute);
      } else if (aa.contains('วันพุธ')) {
        //print("$i.วันพุธ");
        timeWed += int.parse(data[i].minute);
      } else if (aa.contains('วันพฤหัสบดี')) {
        //print("$i.วันพฤหัสบดี");
        timeThu += int.parse(data[i].minute);
      } else if (aa.contains('วันศุกร์')) {
        //print("$i.วันศุกร์");
        timeFri += int.parse(data[i].minute);
      } else if (aa.contains('วันอาทิตย์')) {
        //print("$i.วันอาทิตย์");
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
      timeSat = timeSat;
      timeFrii = timeFri;
      timeThu = timeThu;
      timeWed = timeWed;
      timeMon = timeMon;
      timeSun = timeSun;
      timeTue = timeTue;
    });
  }

  Widget currenWeek() {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Stack(
        children: [
          // SingleChildScrollView(
          //   child: _pageIndicatorText(),
          // ),
          _pageIndicatorText(),
          _previousWeekButton(),
          _nextWeekButton(),
        ],
      ),
    );
  }

  Widget _pageIndicatorText() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.all(25),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.pink.shade100,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Text(
              statController.currentWeek.value,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Widget _previousWeekButton() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: RawMaterialButton(
          onPressed: () {
            if (mounted) {
              setState(() {
                timeLineDay.timeOfFri = 0;
                timeLineDay.timeOfMon = 0;
                timeLineDay.timeOfSat = 0;
                timeLineDay.timeOfSun = 0;
                timeLineDay.timeOfThu = 0;
                timeLineDay.timeOfTue = 0;
                timeLineDay.timeOfWed = 0;
                statController.onPreviousWeek();
                setTimeTocharts.timeOfFriTochart = timeLineDay.timeOfFri;
                setTimeTocharts.timeOfMonTochart = timeLineDay.timeOfMon;
                setTimeTocharts.timeOfSatTochart = timeLineDay.timeOfSat;
                setTimeTocharts.timeOfSunTochart = timeLineDay.timeOfSun;
                setTimeTocharts.timeOfThuTochart = timeLineDay.timeOfThu;
                setTimeTocharts.timeOfTueTochart = timeLineDay.timeOfTue;
                setTimeTocharts.timeOfWedTochart = timeLineDay.timeOfWed;
              });
            }
          },
          elevation: 2.0,
          fillColor: Color.fromARGB(255, 95, 95, 95),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          padding: EdgeInsets.all(8.0),
          shape: CircleBorder(),
        ),
      ),
    );
  }

  Widget _nextWeekButton() {
    return Obx(
      () => Visibility(
        visible: statController.displayNextWeekBtn.value,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: RawMaterialButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    timeLineDay.timeOfFri = 0;
                    timeLineDay.timeOfMon = 0;
                    timeLineDay.timeOfSat = 0;
                    timeLineDay.timeOfSun = 0;
                    timeLineDay.timeOfThu = 0;
                    timeLineDay.timeOfTue = 0;
                    timeLineDay.timeOfWed = 0;
                    statController.onNextWeek();
                    setTimeTocharts.timeOfFriTochart = timeLineDay.timeOfFri;
                    setTimeTocharts.timeOfMonTochart = timeLineDay.timeOfMon;
                    setTimeTocharts.timeOfSatTochart = timeLineDay.timeOfSat;
                    setTimeTocharts.timeOfSunTochart = timeLineDay.timeOfSun;
                    setTimeTocharts.timeOfThuTochart = timeLineDay.timeOfThu;
                    setTimeTocharts.timeOfTueTochart = timeLineDay.timeOfTue;
                    setTimeTocharts.timeOfWedTochart = timeLineDay.timeOfWed;

                    //print(setTimeTocharts.timeOfTueTochart);
                    //print(setTimeTocharts.timeOfThuTochart);
                  });
                }
              },
              elevation: 2.0,
              fillColor: Color.fromARGB(255, 95, 95, 95),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(8.0),
              shape: CircleBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
            ),
          ),
          Text(
            subTitle,
          )
        ],
      ),
    );
  }
}

class setTimeTocharts {
  static late int timeOfMonTochart = 0;
  static late int timeOfTueTochart = 0;
  static late int timeOfWedTochart = 0;
  static late int timeOfThuTochart = 0;
  static late int timeOfFriTochart = 0;
  static late int timeOfSatTochart = 0;
  static late int timeOfSunTochart = 0;
}
