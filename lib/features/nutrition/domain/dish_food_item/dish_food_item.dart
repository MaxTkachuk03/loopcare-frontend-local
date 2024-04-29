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

  double get servingCalories => serving.calories;

  double get servingFiber => serving.fiber;

  double get servingCarbs => serving.carbohydrate;

  double get servingWeight => serving.metricServingAmount ?? 0.0;

  double get servingProtein => serving.protein;

  bool get hasWeight => serving.metricServingAmount != 0 && serving.metricServingAmount != null;

  factory DishFoodItem.fromJson(Map<String, dynamic> json) => _$DishFoodItemFromJson(json);
}
