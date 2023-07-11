part of 'nutrition_instructions_bloc.dart';

@freezed
class NutritionInstructionsState with _$NutritionInstructionsState {
  const NutritionInstructionsState._();

//TODO: old state style
  const factory NutritionInstructionsState.initial() = _Initial;

  const factory NutritionInstructionsState.error(RequestError fetchError) = _Error;

  const factory NutritionInstructionsState.nutritionInstructions({
    required IList<NutritionInstructionValue> calorieDensityValues,
    required IList<NutritionInstructionValue> proteinDegreeValues,
    required NutritionInstructionValue minCalorieDegreeValue,
    required NutritionInstructionValue maxCalorieDegreeValue,
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

    return mapOrNull(nutritionInstructions: (state) {
      if (value < double.parse(state.minCalorieDegreeValue.minValue)) {
        return state.minCalorieDegreeValue;
      }

      if (value > double.parse(state.maxCalorieDegreeValue.maxValue)) {
        return state.maxCalorieDegreeValue;
      }

      return state.calorieDensityValues.firstWhere(_filter(double.parse(value.toStringAsFixed(2))));
    });
  }

  NutritionInstructionValue? getProteinDegreeItem(double? value) {
    if (value == null) return null;

    return mapOrNull(nutritionInstructions: (state) => state.proteinDegreeValues.firstWhere(_filter(value)));
  }
}
