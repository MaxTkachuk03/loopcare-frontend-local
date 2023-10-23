part of 'choose_date_bloc.dart';

@freezed
class ChooseDateState with _$ChooseDateState {
  const ChooseDateState._();

  const factory ChooseDateState.initial(ChooseDateData data) = _Initial;

  const factory ChooseDateState.loading(ChooseDateData data) = _Loading;

  const factory ChooseDateState.calendar(ChooseDateData data) = _Calendar;

  const factory ChooseDateState.error(ChooseDateData data) = _Error;

  bool _isDayEnabledInCalendar(DateTime day) {
    return (day.midnightTime.isAfter(DateTime.now().midnightTime) ||
            day.midnightTime.isSameDate(DateTime.now().midnightTime)) &&
        day.isBefore(
          DateTime.now().midnightTime.add(
                const Duration(days: 15),
              ),
        );
  }

  Map<String, List<WeekDayElement>> get weeks {
    var returnList = <String, List<WeekDayElement>>{};
    final currentWeekNumber = DateTime.now().weekNumber;
    var nextWeekNumber = DateTime.now().nextWeekNumber;
    var secondNextWeekNumber = DateTime.now().secondNextWeekNumber;

    var currentWeekDays = getDatesByWeekNumber(currentWeekNumber, DateTime.now().year);
    var nextWeekDays = getDatesByWeekNumber(nextWeekNumber, DateTime.now().nextWeekYear);
    var secondNextWeekDays = getDatesByWeekNumber(secondNextWeekNumber, DateTime.now().secondNextWeekYear);

    returnList[currentWeekNumber.toString()] = _weekDayElementMapper(currentWeekDays);
    returnList[nextWeekNumber.toString()] = _weekDayElementMapper(nextWeekDays);
    returnList[secondNextWeekNumber.toString()] = _weekDayElementMapper(secondNextWeekDays);

    return returnList;
  }

  _weekDayElementMapper(List<DateTime> list) {
    return list
        .map((e) => WeekDayElement(
              day: e.day,
              month: e.shortMonthString,
              name: e.shortestWeekdayString,
              enabled: _isDayEnabledInCalendar(e),
              filled: Random().nextInt(2) == 1 ? true : false,
              selected: Random().nextInt(5) == 0 ? true : false,
            ))
        .toList();
  }
}

@freezed
class ChooseDateData with _$ChooseDateData {
  const ChooseDateData._();

  const factory ChooseDateData({
    @Default('') String mealCategory,
    @Default(null) DateTime? date,
    @Default(false) bool isLoading,
    RequestError? error,
    DateTime? startTestTime,
  }) = _ChooseDateData;
}
