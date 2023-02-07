part of 'you_and_food_bloc.dart';

@freezed
class YouAndFoodState with _$YouAndFoodState {
  factory YouAndFoodState.initial() =>
      const YouAndFoodState();

  const factory YouAndFoodState({
    dynamic food,
  }) = _YouAndFoodState;

  const YouAndFoodState._();
}
