part of 'you_and_food_bloc.dart';

@freezed
class YouAndFoodState with _$YouAndFoodState {
  const YouAndFoodState._();

  //TODO: old state style need update

  factory YouAndFoodState.initial() => YouAndFoodState(
      foodTypes: <FoodPreference>[].toIList(),
      foodPeriods: <FoodPreference>[].toIList(),
      foodAllergens: <FoodPreference>[].toIList(),
      foodDislikes: <FoodPreference>[].toIList(),
      selectedHates: <FoodPreference>[].toIList(),
      selectedAllergic: <FoodPreference>[].toIList(),
      selectedDislike: <FoodPreference>[].toIList());

  const factory YouAndFoodState({
    @Default(false) bool isCompleted,
    @Default(false) bool saved,
    required IList<FoodPreference> foodTypes,
    required IList<FoodPreference> foodPeriods,
    required IList<FoodPreference> foodAllergens,
    required IList<FoodPreference> foodDislikes,
    required IList<FoodPreference> selectedHates,
    int? selectedPeriod,
    required IList<FoodPreference> selectedAllergic,
    required IList<FoodPreference> selectedDislike,
  }) = _YouAndFoodState;

  IList<String> get selectedHatesNames {
    return selectedHates.map((s) => s.name).toIList();
  }

  IList<String> get selectedAllergicNames {
    return selectedAllergic.map((s) => s.name).toIList();
  }

  IList<String> get selectedDislikesNames {
    return selectedDislike.map((s) => s.name).toIList();
  }

  IList<int> get selectedHatesIds {
    return selectedHates.map((s) => s.id).toIList();
  }

  IList<int> get selectedAllergicIds {
    return selectedAllergic.map((s) => s.id).toIList();
  }

  IList<int> get selectedDislikesIds {
    return selectedDislike.map((s) => s.id).toIList();
  }

  get hasSelectedFoodPreferences {
    return selectedHates.isNotEmpty || selectedAllergic.isNotEmpty || selectedDislike.isNotEmpty;
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
