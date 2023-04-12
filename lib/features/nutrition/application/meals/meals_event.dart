part of 'meals_bloc.dart';

@freezed
class MealsEvent with _$MealsEvent {
  const factory MealsEvent.fetchMeals() = FetchMeals;

  const factory MealsEvent.addMeal(
    String loggingDate,
    String mealCategory,
  ) = AddMeal;

  const factory MealsEvent.addFoodItemToMeal(
    int mealId,
    int foodItemId,
    AddFoodItemToMealBody data,
  ) = AddFoodItemToMeal;

  const factory MealsEvent.updateFoodItemInMeal(
    int mealId,
    int foodItemId,
    AddFoodItemToMealBody data,
  ) = UpdateFoodItemInMeal;

  const factory MealsEvent.deleteMeal(
    int mealId,
  ) = DeleteMeal;

  const factory MealsEvent.deleteFoodItemFromMeal(
    // int mealId,
    String foodItemId,
  ) = DeleteFoodItemFromMeal;

  const factory MealsEvent.createFromFavorites(List<FoodItem> foodItemList) =
      CreateFromFavorites;

  const factory MealsEvent.setMealId(
    int mealId,
  ) = SetMealId;
}
