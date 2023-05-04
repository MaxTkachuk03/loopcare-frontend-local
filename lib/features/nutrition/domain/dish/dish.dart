import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'dish.freezed.dart';

part 'dish.g.dart';

@freezed
abstract class Dish implements _$Dish {
  const Dish._();

  const factory Dish({
    required int id,
    required double numberOfServings,
    required String name,
    required List<DishFoodItem> foodItems,
    required MealCategory mealCategory,
    required int? recipeId,
    required double calorieDensity,
    required double proteinDegree,
    required DateTime createdAt,
    required DateTime updatedAt,
    required ServingSize serving,
  }) = _Dish;

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
}
