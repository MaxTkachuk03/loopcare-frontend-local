import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/direction_item/direction_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';

part 'recipe_details.freezed.dart';

part 'recipe_details.g.dart';

@freezed
abstract class RecipeDetails implements _$RecipeDetails {
  const RecipeDetails._();

  const factory RecipeDetails({
    required int id,
    required String name,
    required String description,
    required List<String>? image,
    required List<DirectionItem> directions,
    required int cookingTimeMin,
    required int preparationTimeMin,
    required List<RecipeFoodItem> ingredients,
    required double calorieDensity,
    required double proteinDegree,
    required List<NutritionItem> nutritionValues,
    required int numberOfServings,
    required double servingAmount,
  }) = _RecipeDetails;

  factory RecipeDetails.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailsFromJson(json);
}
