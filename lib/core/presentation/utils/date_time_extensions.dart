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
    return DateFormat('d MMMM').format(this);
  }

  String get fullDate {
    return DateFormat('EEEE d MMM').format(this);
  }
}
