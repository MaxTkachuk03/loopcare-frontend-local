import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_instruction_value.freezed.dart';

part 'nutrition_instruction_value.g.dart';

@freezed
abstract class NutritionInstructionValue
    implements _$NutritionInstructionValue {
  const NutritionInstructionValue._();

  const factory NutritionInstructionValue({
    required int id,
    required String minValue,
    required String maxValue,
    required String text,
    required String category,
    required String label,
    required String type,
    required String language,
  }) = _NutritionInstructionValue;

  factory NutritionInstructionValue.fromJson(Map<String, dynamic> json) =>
      _$NutritionInstructionValueFromJson(json);
}
