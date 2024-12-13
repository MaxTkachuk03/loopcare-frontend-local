part of 'meals_bloc.dart';

@freezed
class MealsEvent with _$MealsEvent {
  const factory MealsEvent.fetchMeals({required DateTime startDate, required DateTime endDate}) =
      FetchMeals;

  const factory MealsEvent.fetchMealById(int id) = FetchMealById;

  const factory MealsEvent.setMealId(int id, MealCategory mealCategory) = SetMealId;

  const factory MealsEvent.addMeal(MealCategory mealCategory) = AddMeal;

  const factory MealsEvent.addFoodItemToMeal(
      int mealId, String foodItemId, AddFoodItemToMealBody data) = AddFoodItemToMeal;

  const factory MealsEvent.updateFoodItemInMeal(
      int mealId, int foodItemId, AddFoodItemToMealBody data) = UpdateFoodItemInMeal;

  const factory MealsEvent.deleteMeal(int? mealId) = DeleteMeal;

  const factory MealsEvent.deleteCurrentMeal() = DeleteCurrentMeal;

  const factory MealsEvent.deleteFoodItemFromMeal(String foodItemId) = DeleteFoodItemFromMeal;

  const factory MealsEvent.addRecipeToMeal(int mealId, int recipeId) = AddRecipeToMeal;

  const factory MealsEvent.deleteRecipeFromMeal(String recipeId) = DeleteRecipeFromMeal;

  const factory MealsEvent.deleteDishFromMeal(String dishId) = DeleteDishFromMeal;

  const factory MealsEvent.createFromFavorites(List<FavoritesItem> foodItemList) =
      CreateFromFavorites;

  const factory MealsEvent.setCurrentDate(DateTime currentDate) = SetCurrentDate;

  const factory MealsEvent.addDishToMeal(int mealId, String numberOfServings, int dishId) =
      AddDishToMeal;

  const factory MealsEvent.nutritionItemChanged(NutritionValuesTypes item) = NutritionItemChanged;
}
