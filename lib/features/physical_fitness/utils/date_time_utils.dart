import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';

List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(
      DateTime(
          startDate.year,
          startDate.month,
          // In Dart you can set more than. 30 days, DateTime will do the trick
          startDate.day + i),
    );
  }
  return days;
}

bool isNotIdentical(List<DateTime> first, List<DateTime> second) {
  if (first.length != second.length) return true;
  return first.where((item) => !item.isContainedIn(second)).toList().isNotEmpty;
}

String formatSecondsToDurationString(int value) {
  Duration duration = Duration(seconds: value);

  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 1));
}

DateTime findLastDateOfTheWeek(DateTime dateTime) {
  return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
}

List<DateTime> getDatesByWeekNumber(
  int weeknumber,
  int year,
) {
  List<DateTime> ret = [];
  var days = ((weeknumber - 1) * 7) + 2;
  for (var i = 0; i < 7; i++) {
    ret.add(DateTime(year, 1, days + i));
  }
  return ret;
}
