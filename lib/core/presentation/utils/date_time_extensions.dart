import 'package:easy_localization/easy_localization.dart';
import "package:moment_dart/moment_dart.dart";

extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool get isToday {
    return isSameDate(DateTime.now());
  }

  DateTime get withCurrentTime {
    final currentDate = DateTime.now();
    return DateTime(year, month, day, currentDate.hour, currentDate.minute, currentDate.second);
  }

  bool get isFuture {
    return beginDay.isAfter(DateTime.now().beginDay);
  }

  bool get isTodayOrFuture {
    return isSameDate(DateTime.now()) || beginDay.isAfter(DateTime.now().beginDay);
  }

  DateTime get midnightTime {
    return DateTime(year, month, day);
  }

  String get utsIsoStringWeekBeforeDateWithMidnightTime =>
      midnightTime.subtract(const Duration(days: 8)).toUtc().toIso8601String();

  String get utcIsoStringFormat => toUtc().toIso8601String();

  String get fullDateWithHyphen {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String get dateStringOnly {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  DateTime get dateOnly {
    return DateTime(year, month, day);
  }

  String get isoStringWithoutTime {
    return toIso8601String().split('T')[0];
  }

  String get shortDate {
    return DateFormat('d MMMM', 'en_EN').format(this);
  }

  String get shortDateWithYear {
    return DateFormat('d MMMM y', 'en_EN').format(this);
  }

  String get americanShortDateWithYear {
    return Moment(this).format('MMMM Do YYYY');
  }

  String get fullDate {
    return DateFormat('EEEE d MMM', 'en_EN').format(this);
  }

  String get dayWithMonthWithoutLeadingZero {
    return DateFormat('EEEE d MMMM', 'en_EN').format(this);
  }

  String get dayWithMonth {
    return DateFormat('EEEE dd MMMM', 'en_EN').format(this);
  }

  String get fullDateWithYear {
    return DateFormat('EEEE d MMMM y', 'en_EN').format(this);
  }

  String get timeHoursMinutes24 {
    return DateFormat('HH:mm', 'en_EN').format(this);
  }

  String get timeHoursMinutes12 {
    return DateFormat.jm('en_EN').format(this);
  }

  String get timeHoursMinutes {
    return DateFormat('HH:mma', 'en_EN').format(this);
  }

  String get weekdayString {
    return DateFormat('EEEE', 'en_EN').format(this);
  }

  String get toDateFormat => DateFormat('EEEE d MMMM', 'en_EN').format(this);

  String get toTimeFormat => DateFormat('HH:mm', 'en_EN').format(this);

  String get shortWeekdayString {
    return DateFormat('E', 'en_EN').format(this);
  }

  String get shortWeekdayWithMonth {
    return DateFormat('E dd MMMM', 'en_EN').format(this);
  }

  String get shortestWeekdayString {
    return DateFormat('E', 'en_EN').format(this).substring(0, 1);
  }

  String get shortMonthString {
    return DateFormat('MMM', 'en_EN').format(this);
  }

  String get dayInMonth {
    return DateFormat('d', 'en_EN').format(this);
  }

  String get plusWeekShortVersion {
    return add(const Duration(days: 7)).dayWithMonthWithoutLeadingZero;
  }

  int get secondNextWeekNumber {
    return add(const Duration(days: 14)).weekNumber;
  }

  int get nextWeekNumber {
    return add(const Duration(days: 7)).weekNumber;
  }

  int get nextWeekYear {
    final now = this;
    return nextWeekNumber > weekNumber ? now.year : now.year + 1;
  }

  int get secondNextWeekYear {
    final now = this;
    return secondNextWeekNumber > weekNumber ? now.year : now.year + 1;
  }

  int get weekNumber {
    final woy = ((ordinalDate - weekday + 10) ~/ 7);
    if (woy == 0) {
      return DateTime(year - 1, 12, 28).weekNumber;
    }
    if (woy == 53 &&
        DateTime(year, 1, 1).weekday != DateTime.thursday &&
        DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }

    return woy;
  }

  int get ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  bool get isLeapYear {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  bool isContainedIn(List<DateTime>? list) {
    if (list == null) {
      return false;
    }
    final now = this;
    for (var i = 0; i < list.length; i++) {
      if (list[i].isSameDate(now)) {
        return true;
      }
    }
    return false;
  }

  int containedIndex(List<DateTime>? list) {
    if (list == null) {
      return -1;
    }
    final now = this;
    for (var i = 0; i < list.length; i++) {
      if (list[i].isSameDate(now)) {
        return i;
      }
    }
    return -1;
  }

  DateTime fromMilliseconds(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  int weeksBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inDays / 7).ceil();
  }

  get firstDayOfCurrentWeek {
    final date = subtract(Duration(days: weekday - 1));

    return DateTime(date.year, date.month, date.day);
  }

  get firstDayOfPreviousWeek {
    final date = subtract(Duration(days: weekday - 1)).subtract(const Duration(days: 7));

    return DateTime(date.year, date.month, date.day);
  }

  bool get isLastDayOfWeek {
    return isSameDate(lastDayOfCurrentWeek);
  }

  get lastDayOfCurrentWeek {
    final date = add(Duration(days: DateTime.daysPerWeek - weekday));

    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  get firstDayOfNextWeek {
    final date = add(Duration(days: DateTime.daysPerWeek + weekday - 1));

    return DateTime(date.year, date.month, date.day);
  }

  get lastDayOfNextWeek {
    final date = add(Duration(days: DateTime.daysPerWeek + DateTime.daysPerWeek - weekday));

    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  get beginDay {
    final now = this;

    return DateTime(now.year, now.month, now.day, 0, 0, 0);
  }

  get endDay {
    final now = this;

    return DateTime(now.year, now.month, now.day, 23, 59, 59);
  }

  bool inRange(DateTime startDate, DateTime endTime) {
    return (isBefore(endTime) || isSameDate(endTime)) &&
        (isAfter(startDate) || (isSameDate(startDate)));
  }
}

String getFormattedDateFromMilliseconds(int milliseconds) =>
    DateFormat('HH:mm', 'en_EN').format(DateTime.fromMillisecondsSinceEpoch(milliseconds));

List<DateTime> getDays({required DateTime start, required DateTime end}) {
  final days = end.difference(start).inDays;

  return [for (int i = 0; i < days; i++) start.add(Duration(days: i))];
}

List<DateTime> getDaysOnly({required DateTime start, required DateTime end}) {
  final days = end.difference(start).inDays;

  return [for (int i = 0; i < days; i++) start.add(Duration(days: i)).dateOnly];
}

DateTime getDateOnly(String date) => DateFormat("yyyy-MM-dd").parse(date);
