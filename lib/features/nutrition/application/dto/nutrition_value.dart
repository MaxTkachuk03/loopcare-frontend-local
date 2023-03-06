import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_value.freezed.dart';

part 'nutrition_value.g.dart';

@freezed
abstract class NutritionValue implements _$NutritionValue {
  const NutritionValue._();

  const factory NutritionValue({
    required int id,
    required String minValue,
    required String maxValue,
    required String text,
    required String category,
    required String label,
    required String type,
    required String language,
  }) = _NutritionValue;

  factory NutritionValue.fromJson(Map<String, dynamic> json) =>
      _$NutritionValueFromJson(json);
}
