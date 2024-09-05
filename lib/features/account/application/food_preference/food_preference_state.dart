part of 'food_preference_bloc.dart';

@freezed
class FoodPreferenceState with _$FoodPreferenceState {
  const FoodPreferenceState._();

  const factory FoodPreferenceState.initial(FoodPreferenceData data) = InitialFoodPreference;

  const factory FoodPreferenceState.loading(FoodPreferenceData data) = LoadingFoodPreference;

  const factory FoodPreferenceState.loaded(FoodPreferenceData data) = LoadedFoodPreference;

  const factory FoodPreferenceState.error(FoodPreferenceData data) = ErrorFoodPreference;

  const factory FoodPreferenceState.saved(FoodPreferenceData data) = SavedFoodPreference;
}

@freezed
class FoodPreferenceData with _$FoodPreferenceData {
  const FoodPreferenceData._();

  const factory FoodPreferenceData({
    @Default(false) bool isCompleted,
    @Default(false) bool saved,
    int? selectedPeriod,
    @Default([]) List<FoodPreference> foodTypes,
    @Default([]) List<FoodPreference> foodPeriods,
    @Default([]) List<FoodPreference> foodAllergens,
    @Default([]) List<FoodPreference> foodDislikes,
    @Default([]) List<FoodPreference> selectedHates,
    @Default([]) List<FoodPreference> selectedAllergic,
    @Default([]) List<FoodPreference> selectedDislike,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _FoodPreferenceData;

  List<String> get selectedHatesNames => selectedHates.map((s) => s.name).toList();

  List<String> get selectedAllergicNames => selectedAllergic.map((s) => s.name).toList();

  List<String> get selectedDislikesNames => selectedDislike.map((s) => s.name).toList();

  List<int> get selectedHatesIds => selectedHates.map((s) => s.id).toList();

  List<int> get selectedAllergicIds => selectedAllergic.map((s) => s.id).toList();

  List<int> get selectedDislikesIds => selectedDislike.map((s) => s.id).toList();

  get hasSelectedFoodPreferences =>
      selectedHates.isNotEmpty || selectedAllergic.isNotEmpty || selectedDislike.isNotEmpty;

  String? get selectedPeriodName => selectedPeriod != null
      ? foodPeriods.firstWhere((period) => period.id == selectedPeriod).name
      : null;

  bool get userDoesNotEatMeat => selectedHatesNames.contains('Beef') &&
        selectedHatesNames.contains('Pork') &&
        selectedHatesNames.contains('Poultry');

  bool get userDoesNotEatFish => selectedHatesNames.contains('Fish/shellfish');
}