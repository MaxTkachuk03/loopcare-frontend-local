part of 'choose_date_bloc.dart';

@freezed
class ChooseDateEvent with _$ChooseDateEvent {
  const factory ChooseDateEvent.fetchInit(int id) = FetchInit;

  const factory ChooseDateEvent.setData({
    required String mealCategory,
    DateTime? date,
  }) = SetData;
}
