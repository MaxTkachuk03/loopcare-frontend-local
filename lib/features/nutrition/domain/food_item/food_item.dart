import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';
import 'package:loopcare_frontend/features/onboarding_new/utils/weight_conversion_utils.dart';

part 'food_item.freezed.dart';

part 'food_item.g.dart';

@freezed
class FoodItem with _$FoodItem {
  const FoodItem._();

  const factory FoodItem({
    required String id,
    required String foodName,
    required MealItemType foodType,
    required String? brandName,
    required String? foodDescription,
    required ServingSize serving,
  }) = _FoodItem;

  double get calorieDensity {
    num? servingAmount = serving.metricServingAmount;

    servingAmount = serving.metricServingUnit == 'g' || serving.metricServingUnit == 'ml'
        ? servingAmount
        : WeightConversionUtils.convertOzToGrams(servingAmount);

    return double.parse((serving.calories / servingAmount).toStringAsFixed(2));
  }

  factory FoodItem.fromJson(Map<String, dynamic> json) => _$FoodItemFromJson(json);
}
