part of 'nutrition_instructions_bloc.dart';

@freezed
class NutritionInstructionsState with _$NutritionInstructionsState {
  const NutritionInstructionsState._();

  const factory NutritionInstructionsState.initial() = _Initial;

  const factory NutritionInstructionsState.nutritionInstructions({
    required IList<NutritionInstructionValue> calorieDensityValues,
    required IList<NutritionInstructionValue> proteinDegreeValues,
    required double proteinDegreeValue,
    required double calorieDensityValue,
    required bool isDisabled,
  }) = _NutritionInstructions;

  _filter(double value) => (NutritionInstructionValue el) {
        final double doubleMinValue = double.parse(el.minValue);
        final double doubleMaxValue = double.parse(el.maxValue);

        return doubleMinValue <= value && value <= doubleMaxValue;
      };

  NutritionInstructionValue? getCalorieDensityItem(double? value) {
    if (value == null) return null;

    return mapOrNull(
        nutritionInstructions: (state) => state.calorieDensityValues
            .firstWhere(_filter(double.parse(value.toStringAsFixed(2)))));
  }

  NutritionInstructionValue? getProteinDegreeItem(double? value) {
    if (value == null) return null;

    return mapOrNull(
        nutritionInstructions: (state) =>
            state.proteinDegreeValues.firstWhere(_filter(value)));
  }
}
