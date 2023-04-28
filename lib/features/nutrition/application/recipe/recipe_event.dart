part of 'recipe_bloc.dart';

@freezed
class RecipeEvent with _$RecipeEvent {
  const factory RecipeEvent.fetchRecipe(int id) = FetchRecipe;

  const factory RecipeEvent.fetchRecipeFromMeal({
    required int recipeId,
    required int mealId,
  }) = FetchRecipeFromMeal;

  const factory RecipeEvent.nutritionItemChanged(NutritionItem item) =
      NutritionItemChanged;

  const factory RecipeEvent.servingChanged({
    required int mealId,
    required int servingAmount,
  }) = ServingChanged;

  const factory RecipeEvent.addFoodItemToRecipe({
    required int mealId,
    required String foodItemId,
    required int numberOfUnits,
    required String servingId,
  }) = AddFoodItemToRecipe;

  const factory RecipeEvent.removeFoodItemFromRecipe({
    required int mealId,
    required String foodItemId,
  }) = RemoveFoodItemToRecipe;

  const factory RecipeEvent.updateFoodItemFromRecipe({
    required int mealId,
    required String foodItemId,
    required double numberOfUnits,
    required String servingId,
  }) = UpdateFoodItemToRecipe;
}
