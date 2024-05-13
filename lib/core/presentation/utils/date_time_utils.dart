import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/domain/slider_calendar/week_element.dart';

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(
      DateTime(
        startDate.year,
        startDate.month,
        // In Dart you can set more than. 30 days, DateTime will do the trick
        startDate.day + i,
      ),
    );
  }
  return days;
}

List<WeekElement> getWeeksElementBetween(DateTime startDate, DateTime endDate) {
  var utcDate = DateTime.utc(startDate.year, startDate.month, startDate.day);
  var date = findFirstDateOfTheWeek(utcDate);

  List<WeekElement> weeks = List.generate(
    (getWeeksBetween(startDate, endDate)),
    (int index) {
      date = date.add(const Duration(days: 7));

      return WeekElement(
        startDate: date,
        endDate: date.lastDayOfCurrentWeek.toLocal(),
        weekNumber: date.weekNumber,
      );
    },
    growable: false,
  );

  return weeks;
}

List<int> getWeeksNumberBetween(DateTime startDate, DateTime endDate) {
  var date = findFirstDateOfTheWeek(startDate);

  List<int> weeks = List.generate((getWeeksBetween(startDate, endDate)), (int index) {
    date = date.add(const Duration(days: 7));
    return date.weekNumber;
  }, growable: false);

  return weeks;
}

int getWeeksBetween(DateTime startDate, DateTime endDate) {
  var daysBetween = endDate.difference(startDate).inDays;
  var weeks = (daysBetween / 7).floor();

  return weeks;
}

bool isNotIdentical(List<DateTime> first, List<DateTime> second) {
  if (first.length != second.length) return true;
  return first.where((item) => !item.isContainedIn(second)).toList().isNotEmpty;
}

String formatSecondsToTimeString(int value) {
  return _DayAndTime.fromSeconds(value).formatToTimeString();
}

String formatSecondsToDurationString(int value, {bool alwaysShowSeconds = false}) {
  return _DayAndTime.fromSeconds(value).formatToDurationString(alwaysShowSeconds);
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

/// Values of [DateTime] can confuse, because zero value interpret as -1
class _DayAndTime {
  final int day;
  final int hour;
  final int minute;
  final int second;

  const _DayAndTime([this.day = 0, this.hour = 0, this.minute = 0, this.second = 0]);

  factory _DayAndTime.fromSeconds(int value) {
    Duration duration = Duration(seconds: value);

    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return _DayAndTime(days, hours, minutes, seconds);
  }

  String formatToDurationString([bool alwaysShowSeconds = false]) {
    String dayStr = day > 0 ? '${day}d ' : '';
    String hourStr = hour > 0 ? '${hour}h ' : '';
    String minStr = minute > 0 ? '${minute}m ' : '';
    String secStr = second > 0 ? '${second}s' : '';

    return dayStr.isEmpty && hourStr.isEmpty && minStr.isEmpty
        ? secStr
        : '$dayStr$hourStr$minStr${alwaysShowSeconds ? secStr : ''}';
  }

  String formatToTimeString() {
    return '$hour:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  }
}