part of 'recipe_bloc.dart';

@freezed
class RecipeEvent with _$RecipeEvent {
  const factory RecipeEvent.fetchRecipe(int id) = FetchRecipe;

  const factory RecipeEvent.getRecommendations(String mealCategory) = GetRecommendations;

  const factory RecipeEvent.fetchRecipeFromMeal({
    required int recipeId,
    required int mealId,
  }) = FetchRecipeFromMeal;

  const factory RecipeEvent.nutritionItemChanged(NutritionValuesTypes item) = NutritionItemChanged;

  const factory RecipeEvent.servingChanged({
    required int mealId,
    required double servingAmount,
    required int recipeId,
  }) = ServingChanged;

  const factory RecipeEvent.addFoodItemToRecipe({
    required int mealId,
    required String foodItemId,
    required double numberOfUnits,
    required String servingId,
    required int recipeId,
  }) = AddFoodItemToRecipe;

  const factory RecipeEvent.removeFoodItemFromRecipe({
    required int mealId,
    required String foodItemId,
    required int recipeId,
  }) = RemoveFoodItemToRecipe;

  const factory RecipeEvent.updateFoodItemFromRecipe({
    required int mealId,
    required String foodItemId,
    required double numberOfUnits,
    required String servingId,
    required int recipeId,
  }) = UpdateFoodItemToRecipe;
}
