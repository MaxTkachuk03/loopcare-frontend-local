part of 'you_and_food_bloc.dart';

@freezed
class YouAndFoodState with _$YouAndFoodState {
  factory YouAndFoodState.initial() =>  YouAndFoodState(
        foodTypes: <FoodPreference>[].toIList(),
        foodPeriods: <FoodPreference>[].toIList(),
        foodItems: <FoodPreference>[].toIList(),
      );

  const factory YouAndFoodState({
    required IList<FoodPreference> foodTypes,
    required IList<FoodPreference> foodPeriods,
    required IList<FoodPreference> foodItems,
    IList<int>? selectedHates,
    int? selectedPeriod,
    IList<int>? selectedAllergic,
    IList<int>? selectedDislike,
  }) = _YouAndFoodState;

  const YouAndFoodState._();
}
