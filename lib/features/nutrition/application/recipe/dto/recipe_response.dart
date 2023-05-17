import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'recipe_response.g.dart';

@immutable
@JsonSerializable()
class RecipeResponse {
  final int id;
  final String externalId;
  final List<RecipeFoodItem> ingredients;
  final double calorieDensity;
  final double proteinDegree;
  final ServingSize servingSize;
  final int numberOfServings;

  const RecipeResponse({
    required this.id,
    required this.externalId,
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
