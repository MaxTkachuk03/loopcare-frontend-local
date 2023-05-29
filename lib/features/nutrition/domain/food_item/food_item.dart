import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/weight_conversion_utils.dart';

part 'food_item.freezed.dart';

part 'food_item.g.dart';

@freezed
abstract class FoodItem implements _$FoodItem {
  const FoodItem._();

  const factory FoodItem({
    required String id,
    required String foodName,
    required String foodType,
    required String brandName,
    required String? foodDescription,
    required ServingSize serving,
  }) = _FoodItem;

  double get calorieDensity {
    num? servingAmount = serving.metricServingAmount;
    if (servingAmount == null) return 1.0;

    servingAmount = serving.metricServingUnit == 'g'
        ? servingAmount
        : WeightConversionUtils.convertOzToGramms(servingAmount);

    return double.parse((serving.calories / servingAmount).toStringAsFixed(2));
  }

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);
}
