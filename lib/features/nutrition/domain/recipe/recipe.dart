import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';

part 'recipe.freezed.dart';

part 'recipe.g.dart';

@freezed
abstract class Recipe implements _$Recipe {
  const Recipe._();

  const factory Recipe({
    @Default(0) int id,
    @Default('') String externalId,
    @Default([]) List<RecipeFoodItem> ingredients,
    @Default(0) double calorieDensity,
    @Default(0) double proteinDegree,
    @Default([]) List<NutritionItem> nutritionValues,
    @Default(0) int numberOfServings,
    @Default(0) double servingAmount,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
