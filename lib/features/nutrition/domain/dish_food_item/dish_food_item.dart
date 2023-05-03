import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';

part 'dish_food_item.freezed.dart';

part 'dish_food_item.g.dart';

@freezed
abstract class DishFoodItem implements _$DishFoodItem {
  const DishFoodItem._();

  const factory DishFoodItem({
    required int id,
    required String foodName,
    required String brandName,
    required double calorieDensity,
    required double proteinDegree,
    required FoodItemServing serving,
  }) = _DishFoodItem;

  factory DishFoodItem.fromJson(Map<String, dynamic> json) =>
      _$DishFoodItemFromJson(json);
}
