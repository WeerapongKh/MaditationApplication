import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      monthViewSettings: const MonthViewSettings(
          dayFormat: 'EEE',
          numberOfWeeksInView: 4,
          appointmentDisplayCount: 2,
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          showAgenda: false,
          navigationDirection: MonthNavigationDirection.horizontal),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      onTap: (dynamic) {
        print("s");
      },
    );
  }
}
