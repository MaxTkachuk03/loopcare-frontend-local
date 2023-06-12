part of 'you_and_food_bloc.dart';

@freezed
class YouAndFoodEvent with _$YouAndFoodEvent {
  const factory YouAndFoodEvent.fetchFoodPrefsTypes() = FetchFoodPrefsTypes;

  const factory YouAndFoodEvent.foodPrefsPeriods() = FoodPrefsPeriods;

  const factory YouAndFoodEvent.foodPrefsDislikes() = FoodPrefsDislikes;

  const factory YouAndFoodEvent.foodPrefsAllergens() = FoodPrefsAllergens;

  const factory YouAndFoodEvent.setHates(int value) = SetHates;

  const factory YouAndFoodEvent.setPeriod(int value) = SetPeriod;

  const factory YouAndFoodEvent.setAllergic(int value) = SetAllergic;

  const factory YouAndFoodEvent.setDislike(int value) = SetDislike;

  const factory YouAndFoodEvent.fetchFoodPreferences() = FetchFoodPreferences;

  const factory YouAndFoodEvent.saveFoodPreferences() = SaveFoodPreferences;

  const factory YouAndFoodEvent.setInitialFoodPreferences({
    required List<int> hates,
    required List<int> allergics,
    required List<int> dislikes,
  }) = SetInitialFoodPreferences;
}
