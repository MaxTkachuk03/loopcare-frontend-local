part of 'meals_bloc.dart';

@freezed
class MealsEvent with _$MealsEvent {
  const factory MealsEvent.fetchMeals() = FetchMeals;

  const factory MealsEvent.fetchMealById(int id) = FetchMealById;

  const factory MealsEvent.setMealId(int id, String mealCategory) = SetMealId;

  const factory MealsEvent.setPlannedMeal(MealsListItem meal) = SetPlannedMeal;

  const factory MealsEvent.logPlannedMeal(int plannedMealId, String mealCategory) = LogPlannedMeal;

  const factory MealsEvent.addMeal(
    String mealCategory,
  ) = AddMeal;

  const factory MealsEvent.addPlannedMeal(
    String mealCategory,
  ) = AddPlannedMeal;

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
    int recipeId,
  ) = AddRecipeToMeal;

  const factory MealsEvent.deleteRecipeFromMeal(
    String recipeId,
  ) = DeleteRecipeFromMeal;

  const factory MealsEvent.deleteDishFromMeal(
    String dishId,
  ) = DeleteDishFromMeal;

  const factory MealsEvent.createFromFavorites(List<FavoritesItem> foodItemList) = CreateFromFavorites;

  const factory MealsEvent.setCurrentDate(
    DateTime currentDate,
  ) = SetCurrentDate;

  const factory MealsEvent.addDishToMeal(
    MealsListItem meal,
  ) = AddDishToMeal;

  const factory MealsEvent.nutritionItemChanged(NutritionValuesTypes item) = NutritionItemChanged;

  const factory MealsEvent.updatePlannedMeal(
    int mealId,
    List<DateTime> planningDates,
  ) = UpdatePlannedMeal;
}
