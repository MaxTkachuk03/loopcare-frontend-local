part of 'meals_bloc.dart';

@freezed
class MealsEvent with _$MealsEvent {
  const factory MealsEvent.fetchMeals() = FetchMeals;

  const factory MealsEvent.addMeal(
    String loggingDate,
    String mealCategory,
  ) = AddMeal;

  const factory MealsEvent.addFoodItemToMeal(
    String mealId,
    String foodItemId,
    AddFoodItemToMealBody data,
  ) = AddFoodItemToMeal;

  const factory MealsEvent.updateFoodItemInMeal(
    String mealId,
    String foodItemId,
    AddFoodItemToMealBody data,
  ) = UpdateFoodItemInMeal;

  const factory MealsEvent.deleteMeal(
    String mealId,
  ) = DeleteMeal;

  const factory MealsEvent.deleteFoodItemFromMeal(
    // String mealId,
    String foodItemId,
  ) = DeleteFoodItemFromMeal;

  const factory MealsEvent.createFromFavorites(List<FoodItem> foodItemList) =
      CreateFromFavorites;

  const factory MealsEvent.setMealId(
    String mealId,
  ) = SetMealId;
}
