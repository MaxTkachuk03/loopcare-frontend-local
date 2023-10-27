part of 'choose_date_bloc.dart';

@freezed
class ChooseDateEvent with _$ChooseDateEvent {
  const factory ChooseDateEvent.init() = Init;

  const factory ChooseDateEvent.setData({
    required String mealCategory,
    List<DateTime>? dates,
    required int currentMealId,
  }) = SetData;

  const factory ChooseDateEvent.selectDate(
    List<DateTime> dates,
  ) = SelectDate;

  const factory ChooseDateEvent.getPlannedMeals(
    DateTime startDate,
    DateTime endDate,
  ) = GetPlannedMeals;
}
