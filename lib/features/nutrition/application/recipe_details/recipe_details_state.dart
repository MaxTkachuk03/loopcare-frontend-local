part of 'recipe_details_bloc.dart';

@freezed
class RecipeDetailsState with _$RecipeDetailsState {
  const RecipeDetailsState._();

  const factory RecipeDetailsState.initial() = Initial;

  const factory RecipeDetailsState.loading() = Loading;

  const factory RecipeDetailsState.recipeInfo({
    required RecipeDetails recipe,
    required NutritionItem currentRecipeNutritionItem,
  }) = RecipeInfo;

//TODO: old state style
  const factory RecipeDetailsState.error(RequestError fetchError) = Error;
}
