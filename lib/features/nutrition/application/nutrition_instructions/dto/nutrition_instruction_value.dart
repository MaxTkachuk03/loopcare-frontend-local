import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_instruction_value.freezed.dart';

part 'nutrition_instruction_value.g.dart';

@freezed
class NutritionInstructionValue with _$NutritionInstructionValue {
  const NutritionInstructionValue._();

  const factory NutritionInstructionValue({
    required String minValue,
    required String maxValue,
    required String text,
    required String label,
  }) = _NutritionInstructionValue;

  factory NutritionInstructionValue.fromJson(Map<String, dynamic> json) =>
      _$NutritionInstructionValueFromJson(json);
}
