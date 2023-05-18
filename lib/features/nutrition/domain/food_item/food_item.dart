import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

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

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);
}
