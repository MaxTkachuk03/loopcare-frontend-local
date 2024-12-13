part of 'recipe_bloc.dart';

@freezed
class RecipeState with _$RecipeState {
  const RecipeState._();

  const factory RecipeState.initial(RecipeData data) = Initial;

  const factory RecipeState.loadingRecipe(RecipeData data) = LoadingRecipe;

  const factory RecipeState.recipeInfo(RecipeData data) = RecipeInfo;

  const factory RecipeState.error(RecipeData data) = Error;

  String get servingAmount {
    return maybeMap(
      recipeInfo: (s) => s.data.recipe.servingAmount.removeDecimalZeroFormat(),
      orElse: () => '1',
    );
  }

  int? get recipeId => mapOrNull(recipeInfo: (s) => s.data.recipe.id);

  String? get externalRecipeId => mapOrNull(
        recipeInfo: (s) => s.data.recipe.externalId,
        loadingRecipe: (s) => s.data.recipe.externalId,
      );

  double? get numberOfUnits => mapOrNull(recipeInfo: (s) => s.data.recipe.servingAmount);
}

@freezed
class RecipeData with _$RecipeData {
  const RecipeData._();

  const factory RecipeData({
    @Default(Recipe()) Recipe recipe,
    @Default([]) List<RecommendationRecipe> recommendationRecipe,
    @Default(NutritionValuesTypes.calories) NutritionValuesTypes currentNutritionType,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _RecipeData;
}
