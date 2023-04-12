part of 'recipe_bloc.dart';

@freezed
class RecipeState with _$RecipeState {
  const RecipeState._();

  const factory RecipeState.initial() = Initial;

  const factory RecipeState.loading() = Loading;

  const factory RecipeState.recipeInfo({
    required Recipe recipe,
    required NutritionItem currentRecipeNutritionItem,
  }) = RecipeInfo;

  const factory RecipeState.error(RequestError fetchError) = Error;
}
