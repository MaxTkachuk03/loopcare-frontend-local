import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime get midnightTime {
    return DateTime(year, month, day);
  }

  String get isoStringWithoutTime {
    return toIso8601String().split('T')[0];
  }

  String get shortDate {
    return DateFormat('d MMMM', 'en_EN').format(this);
  }

  String get fullDate {
    return DateFormat('EEEE d MMM', 'en_EN').format(this);
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

  String get timeHoursMinutes {
    return DateFormat('HH:mma', 'en_EN').format(this);
  }

  String get weekdayString {
    return DateFormat('EEEE', 'en_EN').format(this);
  }

  int get nextWeekNumber {
    final now = this;
    final firstJan = DateTime(now.year, 1, 1);
    final lasdDecember = DateTime(now.year, 12, 31);
    var nowWeekNumber = weeksBetween(firstJan, now);
    var lastWeekNumber = weeksBetween(firstJan, lasdDecember);
    return nowWeekNumber != lastWeekNumber ? nowWeekNumber : 1;
  }

  int get weekNumber {
    final now = this;
    final firstJan = DateTime(now.year, 1, 1);
    return weeksBetween(firstJan, now);
  }

  int weeksBetween(DateTime from, DateTime to) {
    from = DateTime.utc(from.year, from.month, from.day);
    to = DateTime.utc(to.year, to.month, to.day);
    return (to.difference(from).inDays / 7).ceil();
  }

  get firstDayOfCurrentWeek {
    final date = subtract(Duration(days: weekday - 1));

    return DateTime(date.year, date.month, date.day);
  }

  get lastDayOfCurrentWeek {
    final date = add(Duration(days: DateTime.daysPerWeek - weekday));

    return DateTime(date.year, date.month, date.day);
  }
}
