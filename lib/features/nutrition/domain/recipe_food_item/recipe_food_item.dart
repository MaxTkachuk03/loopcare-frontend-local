import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'recipe_food_item.freezed.dart';

part 'recipe_food_item.g.dart';

@freezed
class RecipeFoodItem with _$RecipeFoodItem {
  const RecipeFoodItem._();

  const factory RecipeFoodItem({
    required String id,
    required String externalId,
    required String foodName,
    required String foodType,
    required String brandName,
    required String? foodDescription,
    required ServingSize serving,
  }) = _RecipeFoodItem;

  bool get hasWeight => serving.metricServingAmount != 0;

  double get calories => serving.calories;

  double get servingProtein => serving.protein;

  double get servingWeight => serving.metricServingAmount;

  double get servingCarbohydrates => serving.carbohydrate;

  double get servingFiber => serving.fiber;

  factory RecipeFoodItem.fromJson(Map<String, dynamic> json) => _$RecipeFoodItemFromJson(json);
}
