import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'meal_item.freezed.dart';

part 'meal_item.g.dart';

@freezed
class MealItem with _$MealItem {
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

  factory MealItem.fromJson(Map<String, dynamic> json) =>
      _$MealItemFromJson(json);
}
