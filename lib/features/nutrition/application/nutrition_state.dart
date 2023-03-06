part of 'nutrition_bloc.dart';

@freezed
class NutritionState with _$NutritionState {
  factory NutritionState.initial() => NutritionState(
        calorieDensityValues: <NutritionValue>[].toIList(),
        proteinDegreeValues: <NutritionValue>[].toIList(),
      );

  const factory NutritionState({
    required IList<NutritionValue> calorieDensityValues,
    required IList<NutritionValue> proteinDegreeValues,
  }) = _NutritionState;

  const NutritionState._();
}
