part of 'recipe_bloc.dart';

@freezed
class RecipeState with _$RecipeState {
  const RecipeState._();

  const factory RecipeState.initial(RecipenData data) = Initial;

  const factory RecipeState.loadingRecipe(RecipenData data) = LoadingRecipe;

  const factory RecipeState.recipeInfo(RecipenData data) = RecipeInfo;

  const factory RecipeState.error(RecipenData data) = Error;

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
class RecipenData with _$RecipenData {
  const RecipenData._();

  const factory RecipenData({
    @Default(Recipe()) Recipe recipe,
    @Default([]) List<RecommendationRecipe> recommendationRecipe,
    @Default(NutritionValuesTypes.calories) NutritionValuesTypes currentNutritionType,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _RecipenData;
}
