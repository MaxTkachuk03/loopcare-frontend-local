part of 'nutrition_instructions_bloc.dart';

@freezed
class NutritionInstructionsState with _$NutritionInstructionsState {
  factory NutritionInstructionsState.initial() => NutritionInstructionsState(
        calorieDensityValues: <NutritionValue>[].toIList(),
        proteinDegreeValues: <NutritionValue>[].toIList(),
        proteinDegreeValue: 0.0,
        calorieDensityValue: 0.0,
      );

  const factory NutritionInstructionsState({
    required IList<NutritionValue> calorieDensityValues,
    required IList<NutritionValue> proteinDegreeValues,
    required double proteinDegreeValue,
    required double calorieDensityValue,
  }) = _NutritionInstructionsState;

  _filter(double value) => (NutritionValue el) {
        final double doubleMinValue = double.parse(el.minValue);
        final double doubleMaxValue = double.parse(el.maxValue);

        return doubleMinValue <= value && value <= doubleMaxValue;
      };

  NutritionValue get currentCalorieDensityItem =>
      calorieDensityValues.firstWhere(_filter(calorieDensityValue));

  NutritionValue get currentProteinDegreeItem =>
      proteinDegreeValues.firstWhere(_filter(proteinDegreeValue));

  const NutritionInstructionsState._();
}
