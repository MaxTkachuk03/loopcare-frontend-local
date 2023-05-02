import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

part 'dish.freezed.dart';

part 'dish.g.dart';

@freezed
abstract class Dish implements _$Dish {
  const Dish._();

  const factory Dish({
    required int id,
    required double numberOfServings,
    required String name,
    required List<FoodItem> foodItems,
    required MealCategory mealCategory,
    required int? recipeId,
    required double calorieDensity,
    required double proteinDegree,
    required DateTime createdAt,
    required DateTime updatedAt,
    required FoodItemServing serving,
  }) = _Dish;

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
}
