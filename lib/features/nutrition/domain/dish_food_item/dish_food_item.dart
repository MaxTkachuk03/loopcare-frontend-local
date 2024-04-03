import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'dish_food_item.freezed.dart';

part 'dish_food_item.g.dart';

@freezed
class DishFoodItem with _$DishFoodItem {
  const DishFoodItem._();

  const factory DishFoodItem({
    required int id,
    required String externalId,
    @Default('') String foodName,
    @Default('') String? brandName,
    required double calorieDensity,
    required double proteinDegree,
    required bool excludedFromCalculations,
    required ServingSize serving,
  }) = _DishFoodItem;

  factory DishFoodItem.fromJson(Map<String, dynamic> json) => _$DishFoodItemFromJson(json);
}
