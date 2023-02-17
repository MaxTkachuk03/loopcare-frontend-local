part of 'you_and_food_bloc.dart';

@freezed
class YouAndFoodState with _$YouAndFoodState {
  const YouAndFoodState._();

  factory YouAndFoodState.initial() => YouAndFoodState(
      foodTypes: <FoodPreference>[].toIList(),
      foodPeriods: <FoodPreference>[].toIList(),
      foodItems: <FoodPreference>[].toIList(),
      selectedHates: <int>[].toIList(),
      selectedAllergic: <int>[].toIList(),
      selectedDislike: <int>[].toIList());

  const factory YouAndFoodState({
    @Default(false) bool isCompleted,
    required IList<FoodPreference> foodTypes,
    required IList<FoodPreference> foodPeriods,
    required IList<FoodPreference> foodItems,
    required IList<int> selectedHates,
    int? selectedPeriod,
    required IList<int> selectedAllergic,
    required IList<int> selectedDislike,
  }) = _YouAndFoodState;

  IList<String> get selectedHatesNames {
    return selectedHates.map((hate) {
      final item = foodTypes.firstWhere((type) => type.id == hate);

      return item.name;
    }).toIList();
  }

  IList<String> get selectedAllergicNames {
    return selectedAllergic.map((allergic) {
      final item = foodItems.firstWhere((i) => i.id == allergic);

      return item.name;
    }).toIList();
  }

  IList<String> get selectedDislikesNames {
    return selectedDislike.map((dislike) {
      final item = foodItems.firstWhere((i) => i.id == dislike);

      return item.name;
    }).toIList();
  }

  String? get selectedPeriodName {
    if (selectedPeriod == null) return null;

    return foodPeriods.firstWhere((period) => period.id == selectedPeriod).name;
  }

  bool get userDoesNotEatMeat {
    return selectedHatesNames.contains('Beef') &&
        selectedHatesNames.contains('Pork') &&
        selectedHatesNames.contains('Poultry');
  }

  bool get userDoesNotEatFish {
    return selectedHatesNames.contains('Fish/shellfish');
  }
}
