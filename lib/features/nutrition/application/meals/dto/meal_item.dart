import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';

part 'meal_item.freezed.dart';

part 'meal_item.g.dart';

@freezed
class MealItem with _$MealItem {
  const factory MealItem({
    required String? description,
    required double calorieDensity,
    required double proteinDegree,
    required int id,
    required String externalId,
    required String name,
    required String type,
    required FoodItemServing serving,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MealItem;

  factory MealItem.fromJson(Map<String, dynamic> json) =>
      _$MealItemFromJson(json);
}
