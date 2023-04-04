part of 'nutrition_instructions_bloc.dart';

@freezed
class NutritionInstructionsState with _$NutritionInstructionsState {
  const factory NutritionInstructionsState.initial() = _Initial;

  const factory NutritionInstructionsState.disabled() = _Disabled;

  const factory NutritionInstructionsState.nutritionInstructions({
    required IList<NutritionInstructionValue> calorieDensityValues,
    required IList<NutritionInstructionValue> proteinDegreeValues,
    required double proteinDegreeValue,
    required double calorieDensityValue,
  }) = _NutritionInstructions;

  _filter(double value) => (NutritionInstructionValue el) {
        final double doubleMinValue = double.parse(el.minValue);
        final double doubleMaxValue = double.parse(el.maxValue);

        return doubleMinValue <= value && value <= doubleMaxValue;
      };

  NutritionInstructionValue? get currentCalorieDensityItem {
    return mapOrNull(
        nutritionInstructions: (state) => state.calorieDensityValues
            .firstWhere(_filter(state.calorieDensityValue)));
  }

  NutritionInstructionValue? get currentProteinDegreeItem {
    return mapOrNull(
        nutritionInstructions: (state) => state.proteinDegreeValues
            .firstWhere(_filter(state.proteinDegreeValue)));
  }

  const NutritionInstructionsState._();
}
