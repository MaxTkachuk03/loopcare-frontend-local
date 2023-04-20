extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime getMidnightTimeForDate() {
    return DateTime(year, month, day);
  }

  DateTime get midnightTime {
    return DateTime(year, month, day);
  }

  String get isoStringWithoutTime {
    return toIso8601String().split('T')[0];
  }
}
