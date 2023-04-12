import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values/nutrition_values.dart';

part 'recipe_response.g.dart';

@immutable
@JsonSerializable()
class RecipeResponse {
  final int id;
  final List<FoodItem> ingredients;
  final double calorieDensity;
  final double proteinDegree;
  final NutritionValues servingSize;
  final int numberOfServings;

  const RecipeResponse({
    required this.id,
    required this.ingredients,
    required this.calorieDensity,
    required this.proteinDegree,
    required this.servingSize,
    required this.numberOfServings,
  });

  static RecipeResponse fromJson(Map<String, dynamic> json) =>
      _$RecipeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeResponseToJson(this);
}
