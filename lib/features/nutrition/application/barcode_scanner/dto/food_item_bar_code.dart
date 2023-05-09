import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';

part 'food_item_bar_code.freezed.dart';

part 'food_item_bar_code.g.dart';

@freezed
abstract class FoodItemBarCode implements _$FoodItemBarCode {
  const FoodItemBarCode._();

  const factory FoodItemBarCode({
    required String id,
    required String foodName,
    required String foodType,
    required String foodUrl,
    required String brandName,
    required String? foodDescription,
    required List<FoodItemServing> servings,
  }) = _FoodItemBarCode;

  factory FoodItemBarCode.fromJson(Map<String, dynamic> json) =>
      _$FoodItemBarCodeFromJson(json);
}
