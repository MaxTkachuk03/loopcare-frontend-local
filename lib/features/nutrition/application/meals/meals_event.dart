part of 'meals_bloc.dart';

@freezed
class MealsEvent with _$MealsEvent {
  const factory MealsEvent.fetchMeals() = FetchMeals;

  const factory MealsEvent.fetchMealById(int id) = FetchMealById;

  const factory MealsEvent.addMeal(
    String mealCategory,
  ) = AddMeal;

  const factory MealsEvent.addFoodItemToMeal(
    int mealId,
    String foodItemId,
    AddFoodItemToMealBody data,
  ) = AddFoodItemToMeal;

  const factory MealsEvent.updateFoodItemInMeal(
    int mealId,
    int foodItemId,
    AddFoodItemToMealBody data,
  ) = UpdateFoodItemInMeal;

  const factory MealsEvent.deleteMeal(
    int? mealId,
  ) = DeleteMeal;

  const factory MealsEvent.deleteCurrentMeal() = DeleteCurrentMeal;

  const factory MealsEvent.deleteFoodItemFromMeal(
    String foodItemId,
  ) = DeleteFoodItemFromMeal;

  const factory MealsEvent.addRecipeToMeal(
    int mealId,
    String recipeId,
  ) = AddRecipeToMeal;

  const factory MealsEvent.deleteRecipeFromMeal(
    String recipeId,
  ) = DeleteRecipeFromMeal;

  const factory MealsEvent.createFromFavorites(List<FoodItem> foodItemList) =
      CreateFromFavorites;

  const factory MealsEvent.setMealId(
    int mealId,
  ) = SetMealId;

  const factory MealsEvent.setCurrentDate(
    DateTime currentDate,
  ) = SetCurrentDate;

  const factory MealsEvent.addDishToMeal(
    MealsListItem meal,
  ) = AddDishToMeal;
}
