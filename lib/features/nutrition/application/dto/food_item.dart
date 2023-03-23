import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';

part 'food_item.freezed.dart';

part 'food_item.g.dart';

@freezed
abstract class FoodItem implements _$FoodItem {
  const FoodItem._();

  const factory FoodItem({
    required String id,
    required String foodName,
    required String foodType,
    required String foodUrl,
    required String brandName,
    required String? foodDescription,
    required List<FoodItemServing> servings,
  }) = _FoodItem;

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);
}
