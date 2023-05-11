import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/direction_item/direction_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'recipe_details_response.g.dart';

@immutable
@JsonSerializable()
class RecipeDetailsResponse {
  final int id;
  final String externalId;
  final String name;
  final String description;
  final List<String>? image;
  final List<DirectionItem> directions;
  final int cookingTimeMin;
  final int preparationTimeMin;
  final List<RecipeFoodItem> ingredients;
  final double calorieDensity;
  final double proteinDegree;
  final ServingSize servingSize;
  final int numberOfServings;

  const RecipeDetailsResponse({
    required this.id,
    required this.externalId,
    required this.name,
    required this.description,
    required this.image,
    required this.directions,
    required this.cookingTimeMin,
    required this.preparationTimeMin,
    required this.ingredients,
    required this.calorieDensity,
    required this.proteinDegree,
    required this.servingSize,
    required this.numberOfServings,
  });

  static RecipeDetailsResponse fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeDetailsResponseToJson(this);
}
