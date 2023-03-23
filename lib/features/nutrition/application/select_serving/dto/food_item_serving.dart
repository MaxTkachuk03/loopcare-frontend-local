import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_item_serving.freezed.dart';

part 'food_item_serving.g.dart';

@freezed
abstract class FoodItemServing implements _$FoodItemServing {
  const FoodItemServing._();

  const factory FoodItemServing({
    required String? servingId,
    required bool? isSelectedFavorite,
    required double? calcium,
    required double calories,
    required double carbohydrate,
    required double cholesterol,
    required double fat,
    required double fiber,
    required double? iron,
    required String? measurementDescription,
    required double? metricServingAmount,
    required String? metricServingUnit,
    required double? monounsaturatedFat,
    required double numberOfUnits,
    required double? polyunsaturatedFat,
    required double? potassium,
    required double protein,
    required double saturatedFat,
    required String? servingDescription,
    required String? servingUrl,
    required double? sodium,
    required double? sugar,
    required double? transFat,
    required double? vitaminA,
    required double? vitaminC,
    required List<String>? favoriteMealCategories,
  }) = _FoodItemServing;

  String get servingLabel {
    return '$measurementDescription ($metricServingAmount $metricServingUnit)';
  }

  factory FoodItemServing.fromJson(Map<String, dynamic> json) =>
      _$FoodItemServingFromJson(json);
}
