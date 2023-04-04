part of 'nutrition_instructions_bloc.dart';

@freezed
class NutritionInstructionsEvent with _$NutritionInstructionsEvent {
  const factory NutritionInstructionsEvent.fetchValuesExplanation() =
      FetchValuesExplanation;

  const factory NutritionInstructionsEvent.setCalorieDensity(double value) =
      SetCalorieDensity;

  const factory NutritionInstructionsEvent.setProteinDegree(double value) =
      SetProteinDegree;

  const factory NutritionInstructionsEvent.disable() = Disable;
}
