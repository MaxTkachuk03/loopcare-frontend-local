import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'meal_item.freezed.dart';

part 'meal_item.g.dart';

@freezed
class MealItem with _$MealItem {
  const MealItem._();

  const factory MealItem({
    required String? description,
    required double calorieDensity,
    required double? proteinDegree,
    required int id,
    required String? externalId,
    required String name,
    required MealItemType type,
    required ServingSize serving,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MealItem;

  double get servingCalories => serving.calories;

  double get servingWeight => serving.metricServingAmount ?? 0.0;

  bool get hasWeight => serving.metricServingAmount != 0 && serving.metricServingAmount != null;

  factory MealItem.fromJson(Map<String, dynamic> json) => _$MealItemFromJson(json);
}
