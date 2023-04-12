import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values/nutrition_values.dart';

part 'recipe.freezed.dart';

part 'recipe.g.dart';

@freezed
abstract class Recipe implements _$Recipe {
  const Recipe._();

  const factory Recipe({
    required int id,
    required List<FoodItem> ingredients,
    required double calorieDensity,
    required double proteinDegree,
    required NutritionValues servingSize,
    required int numberOfServings,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
