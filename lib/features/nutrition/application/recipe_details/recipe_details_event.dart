part of 'recipe_details_bloc.dart';

@freezed
class RecipeDetailsEvent with _$RecipeDetailsEvent {
  const factory RecipeDetailsEvent.fetchOriginRecipe(int id) = FetchOriginRecipe;

  const factory RecipeDetailsEvent.nutritionItemChanged(NutritionItem item) = NutritionItemChanged;

  const factory RecipeDetailsEvent.servingChanged({
    required int mealId,
    required int servingAmount,
  }) = ServingChanged;
}
