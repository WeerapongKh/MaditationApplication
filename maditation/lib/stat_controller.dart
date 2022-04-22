import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'package:intl/intl.dart';
import 'package:maditation/database/date_db.dart';
import 'package:maditation/model/daily_stat_ui_model.dart';
import 'package:maditation/model/date.dart';
import 'package:maditation/utils/date_util.dart';

class StatController extends GetxController {
  RxString todayStat = "".obs;
  RxString currentWeek = "".obs;

  List<DataModel> data = <DataModel>[].obs;
  late DB db;

  RxList<DailyStatUiModel> dailyStatList1 = (List<DailyStatUiModel>.of([])).obs;

  RxBool displayNextWeekBtn = false.obs;

  int maxSection3 = -1;

  DateTime selectedDate = DateTime.now();

  DateTime currentDate = DateTime.now();

  static var now = DateTime.now();
  var toShow = now.yearInBuddhistCalendar;
  // static var formats = DateFormat.yMMMMEEEEd();
  // var toFormats = formats.formatInBuddhistCalendarThai(now);

  @override
  void onInit() {
    setCurrentWeek();
    super.onInit();
  }

  void getDb() async {
    db = DB();
    data = await db.getData();
  }

  void resetMaxValue() {
    maxSection3 = -1;
    // maxSection2 = -1;
    //maxSection3 = -1;
  }

  void setCurrentWeek() async {
    selectedDate = DateTime.now();
    currentWeek.value = getWeekDisplayDate(selectedDate);
    getDailyStatList(selectedDate);
  }

  void setPreviousWeek() {
    selectedDate = selectedDate.subtract(Duration(days: 7));
    setNextWeekButtonVisibility();
    currentWeek.value = getWeekDisplayDate(selectedDate);
    getDailyStatList(selectedDate);
  }

  void setNextWeek() {
    selectedDate = selectedDate.add(Duration(days: 7));
    setNextWeekButtonVisibility();
    currentWeek.value = getWeekDisplayDate(selectedDate);
    getDailyStatList(selectedDate);
  }

  void setNextWeekButtonVisibility() {
    displayNextWeekBtn.value = !selectedDate.isSameDate(currentDate);
  }

  String getWeekDisplayDate(DateTime dateTime) {
    return '${AppDateUtils.firstDateOfWeek(dateTime).toFormatString('dd MMM', 'th')} - ${AppDateUtils.lastDateOfWeek(dateTime).toFormatString('dd MMM', 'th')}';
  }

  Future<void> getDailyStatList(DateTime dateTime) async {
    resetMaxValue();
    getDb();
    var daysInWeek = AppDateUtils.getDaysInWeek(dateTime);

    //var today = DateTime.now();
    //var todayPosition = DateTime.now().weekday;
    for (var i = 0; i <= 6; i++) {
      var date = daysInWeek[i];
      var formats = DateFormat.yMMMMEEEEd();
      var toFormats = formats.formatInBuddhistCalendarThai(date);

      for (var j = 0; j <= data.length; j++) {
        try {
          if (data[j].day.contains(toFormats)) {
            if (data[j].day.contains("จันทร์")) {
              //print("มีเวลาในวันจันทร์ ");
              timeLineDay.timeOfMon += int.parse(data[j].minute);
            } else if (data[j].day.contains("อังคาร")) {
              //print("มีเวลาในวันอังคาร ");
              timeLineDay.timeOfTue += int.parse(data[j].minute);
            } else if (data[j].day.contains("พุธ")) {
              //print("มีเวลาในวันพุธ  ");
              timeLineDay.timeOfWed += int.parse(data[j].minute);
            } else if (data[j].day.contains("พฤหัสบดี")) {
              //print("มีเวลาในวันพฤหัสบดี ");
              timeLineDay.timeOfThu += int.parse(data[j].minute);
            } else if (data[j].day.contains("ศุกร์")) {
              //print("มีเวลาในวันศุกร์");
              timeLineDay.timeOfFri += int.parse(data[j].minute);
            } else if (data[j].day.contains("เสาร์")) {
              //print("มีเวลาในวันเสาร์ ");
              timeLineDay.timeOfSat += int.parse(data[j].minute);
            } else if (data[j].day.contains("อาทิตย์")) {
              //print("มีเวลาในวันอาทิตย์  ");
              timeLineDay.timeOfSun += int.parse(data[j].minute);
            }
          }
        } catch (e) {
          //print("ไม่มีเวลาที่นั่ง");
        }
      }
    }
  }

  void setSelectedDayPosition(int position, int sectionNumber) {
    switch (sectionNumber) {
      case 1:
        {
          dailyStatList1.assignAll(getDailyListWithSelectedDay(
            dailyStatList1.call(),
            position,
          ));
          break;
        }
    }
  }

  List<DailyStatUiModel> getDailyListWithSelectedDay(
      List<DailyStatUiModel> list, int position) {
    return list
        .map((e) => e.copyWith(isSelected: e.dayPosition == position))
        .toList();
  }

  double getStatPercentage(int time, int type) {
    switch (type) {
      case 1:
        {
          return getSection1StatPercentage(time);
        }

      default:
        return 0.0;
    }
  }

  double getSection1StatPercentage(int time) {
    if (time == 0) {
      return 0;
    } else {
      return time / maxSection3;
    }
  }

  void onNextWeek() {
    setNextWeek();
  }

  void onPreviousWeek() {
    setPreviousWeek();
  }
}

class timeLineDay {
  static late int timeOfMon = 0;
  static late int timeOfTue = 0;
  static late int timeOfWed = 0;
  static late int timeOfThu = 0;
  static late int timeOfFri = 0;
  static late int timeOfSat = 0;
  static late int timeOfSun = 0;
}
