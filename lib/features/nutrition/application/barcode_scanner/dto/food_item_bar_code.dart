import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'food_item_bar_code.freezed.dart';

part 'food_item_bar_code.g.dart';

@freezed
abstract class FoodItemBarCode implements _$FoodItemBarCode {
  const FoodItemBarCode._();

  const factory FoodItemBarCode({
    required String id,
    required String foodName,
    required MealItemType foodType,
    required String foodUrl,
    required String? brandName,
    required String? foodDescription,
    required List<ServingSize> servings,
  }) = _FoodItemBarCode;

  factory FoodItemBarCode.fromJson(Map<String, dynamic> json) =>
      _$FoodItemBarCodeFromJson(json);
}
