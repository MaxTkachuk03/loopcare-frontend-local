import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/domain/slider_calendar/week_element.dart';

List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
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

List<WeekElement> getWeeksElementBeteween(DateTime startDate, DateTime endDate) {
  var utcDate = DateTime.utc(startDate.year, startDate.month, startDate.day);
  var date = findFirstDateOfTheWeek(utcDate);

  List<WeekElement> weeks = List.generate(
    (getWeeksBeteween(startDate, endDate)),
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

List<int> getWeeksNumberBeteween(DateTime startDate, DateTime endDate) {
  var date = findFirstDateOfTheWeek(startDate);

  List<int> weeks = List.generate((getWeeksBeteween(startDate, endDate)), (int index) {
    date = date.add(const Duration(days: 7));
    return date.weekNumber;
  }, growable: false);

  return weeks;
}

int getWeeksBeteween(DateTime startDate, DateTime endDate) {
  var daysBetween = endDate.difference(startDate).inDays;
  var weeks = (daysBetween / 7).floor();

  return weeks;
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

String formatSecondsToEducationDurationString(int value) {
  Duration duration = Duration(seconds: value);

  int days = duration.inDays;
  int hours = duration.inHours.remainder(24);
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);
  String daysStr = days > 0 ? '${days}d ' : '';
  String hoursStr = hours > 0 ? '${hours}h ' : '';
  String minsStr = minutes > 0 ? '${minutes}m ' : '';
  String secStr = seconds > 0 ? '${seconds}s' : '';

  return daysStr.isEmpty && hoursStr.isEmpty && minsStr.isEmpty
      ? '$daysStr$hoursStr$minsStr$secStr'
      : '$daysStr$hoursStr$minsStr';
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
