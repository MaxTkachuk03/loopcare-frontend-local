part of 'choose_date_bloc.dart';

@freezed
class ChooseDateEvent with _$ChooseDateEvent {
  const factory ChooseDateEvent.init() = Init;

  const factory ChooseDateEvent.setData({
    required String mealCategory,
    DateTime? date,
  }) = SetData;

  const factory ChooseDateEvent.selectDate(
    DateTime date,
  ) = SelectDate;
}
