part of 'choose_date_bloc.dart';

@freezed
class ChooseDateState with _$ChooseDateState {
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
    @Default(null) DateTime? date,
    @Default(false) bool isLoading,
    @JsonKey(ignore: true) RequestError? error,
    DateTime? startTestTime,
  }) = _ChooseDateData;

  Map<String, List<WeekDayElement>> get weeks {
    var currentWeek = DateTime.now().weekNumber;
    var nextWeek = DateTime.now().nextWeekNumber;
    var secondNextWeekNumber = DateTime.now().secondNextWeekNumber;
    return {};
  }
}
