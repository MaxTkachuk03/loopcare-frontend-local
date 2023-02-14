part of 'you_and_food_bloc.dart';

@freezed
class YouAndFoodEvent with _$YouAndFoodEvent {
  const factory YouAndFoodEvent.fetchFoodPrefsTypes() = FetchFoodPrefsTypes;

  const factory YouAndFoodEvent.foodPrefsPeriods() = FoodPrefsPeriods;

  const factory YouAndFoodEvent.foodPrefsItems() = FoodPrefsItems;

  const factory YouAndFoodEvent.setHates(int value) = SetHates;

  const factory YouAndFoodEvent.setPeriod(int value) = SetPeriod;

  const factory YouAndFoodEvent.setAllergic(int value) = SetAllergic;

  const factory YouAndFoodEvent.setDislike(int value) = SetDislike;

  const factory YouAndFoodEvent.saveFoodPreferences() = SaveFoodPreferences;
}
