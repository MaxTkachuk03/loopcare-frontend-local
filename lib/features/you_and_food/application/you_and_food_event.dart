part of 'you_and_food_bloc.dart';

@freezed
class YouAndFoodEvent with _$YouAndFoodEvent {
  const factory YouAndFoodEvent.setFood() = SetFood;
}
