part of 'nutrition_instructions_bloc.dart';

@freezed
class NutritionInstructionsState with _$NutritionInstructionsState {
  const NutritionInstructionsState._();

  const factory NutritionInstructionsState.initial(NutritionInstructionsData data) = NutritionInstructionsStateInitial;

  const factory NutritionInstructionsState.loading(NutritionInstructionsData data) = NutritionInstructionsStateLoading;

  const factory NutritionInstructionsState.error(NutritionInstructionsData data) = NutritionInstructionsStateError;

  const factory NutritionInstructionsState.loaded(NutritionInstructionsData data) = NutritionInstructionsStateLoaded;

  factory NutritionInstructionsState.fromJson(Map<String, dynamic> json) => _$NutritionInstructionsStateFromJson(json);
}

@freezed
class NutritionInstructionsData with _$NutritionInstructionsData {
  const NutritionInstructionsData._();

  const factory NutritionInstructionsData({
    @Default([]) List<NutritionInstructionValue> calorieDensityValues,
    @Default([]) List<NutritionInstructionValue> proteinDegreeValues,
    @Default(null) NutritionInstructionValue? minCalorieDegreeValue,
    @Default(null) NutritionInstructionValue? maxCalorieDegreeValue,
    @Default(0.0) double proteinDegreeValue,
    @Default(0.0) double calorieDensityValue,
    @Default(false) bool isLoading,
    @JsonKey(ignore: true) RequestError? error,
  }) = _NutritionInstructionsData;

  _filter(double value) => (NutritionInstructionValue el) {
        final double doubleMinValue = double.parse(el.minValue);
        final double doubleMaxValue = double.parse(el.maxValue);

        return doubleMinValue <= value && value <= doubleMaxValue;
      };

  get alreadyLoaded => calorieDensityValues.isNotEmpty && proteinDegreeValues.isNotEmpty;

  NutritionInstructionValue? getCalorieDensityItem(double? value) {
    if (value == null) return null;

    if (value < double.parse(minCalorieDegreeValue?.minValue ?? '')) {
      return minCalorieDegreeValue;
    }

    if (value > double.parse(maxCalorieDegreeValue?.maxValue ?? '')) {
      return maxCalorieDegreeValue;
    }

    return calorieDensityValues.firstWhere(_filter(double.parse(value.toStringAsFixed(2))));
  }

  NutritionInstructionValue? getProteinDegreeItem(double? value) {
    if (value == null) return null;

    return proteinDegreeValues.firstWhere(_filter(value));
  }

  factory NutritionInstructionsData.fromJson(Map<String, dynamic> json) => _$NutritionInstructionsDataFromJson(json);
}
