part of 'nutrition_instructions_bloc.dart';

@freezed
class NutritionInstructionsState with _$NutritionInstructionsState {
  factory NutritionInstructionsState.initial() => NutritionInstructionsState(
        calorieDensityValues: <NutritionInstructionValue>[].toIList(),
        proteinDegreeValues: <NutritionInstructionValue>[].toIList(),
        proteinDegreeValue: 0.0,
        calorieDensityValue: 0.0,
      );

  const factory NutritionInstructionsState({
    required IList<NutritionInstructionValue> calorieDensityValues,
    required IList<NutritionInstructionValue> proteinDegreeValues,
    required double proteinDegreeValue,
    required double calorieDensityValue,
  }) = _NutritionInstructionsState;

  _filter(double value) => (NutritionInstructionValue el) {
        final double doubleMinValue = double.parse(el.minValue);
        final double doubleMaxValue = double.parse(el.maxValue);

        return doubleMinValue <= value && value <= doubleMaxValue;
      };

  NutritionInstructionValue get currentCalorieDensityItem =>
      calorieDensityValues.firstWhere(_filter(calorieDensityValue));

  NutritionInstructionValue get currentProteinDegreeItem =>
      proteinDegreeValues.firstWhere(_filter(proteinDegreeValue));

  const NutritionInstructionsState._();
}
