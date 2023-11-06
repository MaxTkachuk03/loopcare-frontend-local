import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';

class DashboardUtils {
  static const Duration _editableDuration = Duration(days: 7);

  DashboardUtils._();

  static bool isToday(DateTime date) {
    final todayMidnight = DateTime.now().midnightTime;
    final selectedDateMidnight = date.midnightTime;
    return selectedDateMidnight == todayMidnight;
  }

  static bool isEditable(DateTime date) {
    final todayMidnight = DateTime.now().midnightTime;

    final isPastDate = date.isBefore(todayMidnight);
    final isLessThanSevenDaysPastDate = todayMidnight.difference(date.midnightTime) <= _editableDuration;

    return isToday(date) || (isPastDate && isLessThanSevenDaysPastDate);
  }
}
