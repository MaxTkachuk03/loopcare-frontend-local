part of 'you_and_food_bloc.dart';

@freezed
class YouAndFoodEvent with _$YouAndFoodEvent {
  const factory YouAndFoodEvent.fetchFoodPrefsTypes() = FetchFoodPrefsTypes;

  const factory YouAndFoodEvent.foodPrefsPeriods() = FoodPrefsPeriods;

  const factory YouAndFoodEvent.foodPrefsDislikes() = FoodPrefsDislikes;

  const factory YouAndFoodEvent.foodPrefsAllergens() = FoodPrefsAllergens;

  const factory YouAndFoodEvent.setHates(FoodPreference value) = SetHates;

  // const factory YouAndFoodEvent.setPeriod(FoodPreference value) = SetPeriod;

  const factory YouAndFoodEvent.setAllergic(FoodPreference value) = SetAllergic;

  const factory YouAndFoodEvent.setDislike(FoodPreference value) = SetDislike;

  const factory YouAndFoodEvent.fetchFoodPreferences() = FetchFoodPreferences;

  const factory YouAndFoodEvent.saveFoodPreferences() = SaveFoodPreferences;

  const factory YouAndFoodEvent.setInitialFoodPreferences({
    required List<FoodPreference> hates,
    required List<FoodPreference> allergics,
    required List<FoodPreference> dislikes,
  }) = SetInitialFoodPreferences;
}
