part of 'choose_date_bloc.dart';

@freezed
class ChooseDateState with _$ChooseDateState {
  const ChooseDateState._();

  const factory ChooseDateState.initial(ChooseDateData data) = _Initial;

  const factory ChooseDateState.loading(ChooseDateData data) = _Loading;

  const factory ChooseDateState.calendar(ChooseDateData data) = _Calendar;

  const factory ChooseDateState.error(ChooseDateData data) = _Error;
}

@freezed
class ChooseDateData with _$ChooseDateData {
  const ChooseDateData._();

  const factory ChooseDateData({
    @Default('') String mealCategory,
    @Default(-1) int currentMealId,
    @Default(null) DateTime? currentDate,
    @Default([]) List<DateTime> selectedDateList,
    @Default([]) List<DateTime> originSelectedDateList,
    @Default({}) Map<String, List<WeekDayElement>> weekDayElementList,
    @Default({}) Map<String, List<MealsListItem>> plannedMeals,
    @Default(false) bool isLoading,
    @Default(false) bool canSave,
    @Default(null) DateTime? warningDate,
    @Default(false) bool showSaveWarning,
    @Default(false) bool showReplaceWarning,
    @Default(null) DateTime? selectedDate,
    RequestError? error,
    DateTime? startTestTime,
  }) = _ChooseDateData;

  DateTime get getWarningDate {
    return warningDate ?? DateTime.now();
  }

  DateTime get getCurrentDate {
    return currentDate ?? DateTime.now();
  }

  List<MealsListItem> get plannedMealsForWarningDate {
    return plannedMeals[getWarningDate.isoStringWithoutTime] ?? [];
  }

  List<MealsListItem> get plannedMealsForCurrentDate {
    return plannedMeals[getCurrentDate.isoStringWithoutTime] ?? [];
  }

  Map<String, List<MealsListItem>> get plannedMealsForSelectedWeek {
    var retList = <String, List<MealsListItem>>{};

    if (currentDate != null) {
      var startWeekDay = currentDate?.firstDayOfCurrentWeek;
      var daysOfWeek = getDaysInBeteween(startWeekDay, startWeekDay.add(const Duration(days: 6)));

      retList = {for (var item in daysOfWeek) item.isoStringWithoutTime: []};

      if (plannedMeals.isNotEmpty) {
        plannedMeals.forEach((key, value) {
          var plannedDate = DateTime.parse(key);
          if (plannedDate.isSameDate(currentDate?.firstDayOfCurrentWeek) ||
              plannedDate.isSameDate(currentDate?.lastDayOfCurrentWeek) ||
              plannedDate.isAfter(currentDate?.firstDayOfCurrentWeek) &&
                  plannedDate.isBefore(currentDate?.lastDayOfCurrentWeek)) {
            retList[key] = value;
          }
        });
      }
    }
    return retList;
  }

  _weekDayElementMapper(List<DateTime> list) {
    return list
        .map(
          (e) => WeekDayElement(
            date: e,
            day: e.day,
            month: e.shortMonthString,
            name: e.shortestWeekdayString,
            enabled: _isDayEnabledInCalendar(e),
            filled: e.isContainedIn(filledDateList),
            selected: e.isContainedIn(selectedDateList),
          ),
        )
        .toList();
  }

  List<DateTime> get initSelectedDateList {
    var retList = <DateTime>[];
    if (plannedMeals.isNotEmpty) {
      plannedMeals.forEach((key, value) {
        if (value.where((event) => event.id == currentMealId).toList().isNotEmpty) {
          retList.add(DateTime.parse(key));
        }
      });
    }
    return retList;
  }

  List<DateTime> get filledDateList {
    var retList = <DateTime>[];
    if (plannedMeals.isNotEmpty) {
      plannedMeals.forEach((key, value) {
        if (value
            .where((element) => (element.id != currentMealId && element.mealCategory == mealCategory))
            .toList()
            .isNotEmpty) {
          retList.add(DateTime.parse(key));
        }
      });
    }
    return retList;
  }

  bool _isDayEnabledInCalendar(DateTime day) {
    return day.midnightTime.isAfter(DateTime.now().midnightTime) &&
        day.isBefore(DateTime.now().midnightTime.add(const Duration(days: 15)));
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
}
