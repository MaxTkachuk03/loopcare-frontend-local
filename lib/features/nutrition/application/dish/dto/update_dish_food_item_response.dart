import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'update_dish_food_item_response.g.dart';

@immutable
@JsonSerializable()
class UpdateDishFoodItemResponse {
  final int id;
  final double numberOfServings;
  final String name;
  final List<DishFoodItem> foodItems;
  final List<MealCategory> mealCategories;
  final int? recipeId;
  final double calorieDensity;
  final double proteinDegree;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ServingSize serving;

  const UpdateDishFoodItemResponse(
    this.id,
    this.numberOfServings,
    this.name,
    this.foodItems,
    this.mealCategories,
    this.recipeId,
    this.calorieDensity,
    this.proteinDegree,
    this.createdAt,
    this.updatedAt,
    this.serving,
  );

  static UpdateDishFoodItemResponse fromJson(Map<String, dynamic> json) =>
      _$UpdateDishFoodItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDishFoodItemResponseToJson(this);
}
