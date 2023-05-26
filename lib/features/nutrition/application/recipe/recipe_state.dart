part of 'recipe_bloc.dart';

@freezed
class RecipeState with _$RecipeState {
  const RecipeState._();

  const factory RecipeState.initial() = Initial;

  const factory RecipeState.loading() = Loading;

  const factory RecipeState.recipeInfo({
    required Recipe recipe,
    @Default(NutritionValuesTypes.calories)
        NutritionValuesTypes currentNutritionType,
  }) = RecipeInfo;

  const factory RecipeState.error(RequestError fetchError) = Error;

  String get servingAmount {
    return maybeMap(
      recipeInfo: (s) => s.recipe.servingAmount.removeDecimalZeroFormat(),
      orElse: () => '1',
    );
  }

  int? get recipeId => mapOrNull(recipeInfo: (s) => s.recipe.id);

  String? get externalRecipeId =>
      mapOrNull(recipeInfo: (s) => s.recipe.externalId);

  double? get numberOfUnits =>
      mapOrNull(recipeInfo: (s) => s.recipe.servingAmount);
}
