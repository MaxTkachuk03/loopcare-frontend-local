import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';

part 'recipe.freezed.dart';

part 'recipe.g.dart';

@freezed
abstract class Recipe implements _$Recipe {
  const Recipe._();

  const factory Recipe({
    required int id,
    required List<RecipeFoodItem> ingredients,
    required double calorieDensity,
    required double proteinDegree,
    required List<NutritionItem> nutritionValues,
    required int numberOfServings,
    required double servingAmount,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
