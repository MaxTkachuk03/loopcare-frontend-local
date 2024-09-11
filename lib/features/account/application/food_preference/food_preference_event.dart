part of 'food_preference_bloc.dart';

@freezed
class FoodPreferenceEvent with _$FoodPreferenceEvent {
  const factory FoodPreferenceEvent.fetchFoodPrefsTypes() = FetchFoodPrefsTypes;

  const factory FoodPreferenceEvent.foodPrefsPeriods() = FoodPrefsPeriods;

  const factory FoodPreferenceEvent.foodPrefsDislikes() = FoodPrefsDislikes;

  const factory FoodPreferenceEvent.foodPrefsAllergens() = FoodPrefsAllergens;

  const factory FoodPreferenceEvent.setHates(FoodPreference value) = SetHates;

  const factory FoodPreferenceEvent.setAllergic(FoodPreference value) = SetAllergic;

  const factory FoodPreferenceEvent.setDislike(FoodPreference value) = SetDislike;

  const factory FoodPreferenceEvent.fetchFoodPreferences() = FetchFoodPreferences;

  const factory FoodPreferenceEvent.saveFoodPreferences() = SaveFoodPreferences;

  const factory FoodPreferenceEvent.setInitialFoodPreferences({
    required List<FoodPreference> hates,
    required List<FoodPreference> allergics,
    required List<FoodPreference> dislikes,
  }) = SetInitialFoodPreferences;
}
