part of 'nutrition_instructions_bloc.dart';

@freezed
class NutritionInstructionsEvent with _$NutritionInstructionsEvent {
  const factory NutritionInstructionsEvent.fetchValuesExplanation() =
      FetchValuesExplanation;

  const factory NutritionInstructionsEvent.disable() = Disable;
}
