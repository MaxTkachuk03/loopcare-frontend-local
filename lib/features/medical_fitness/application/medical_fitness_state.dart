part of 'medical_fitness_bloc.dart';

@freezed
class MedicalFitnessState with _$MedicalFitnessState {
  factory MedicalFitnessState.initial() => MedicalFitnessState(
        currentQuestion: MedicalFitnessQuestions.values[0],
      );

  const factory MedicalFitnessState({
    required MedicalFitnessQuestions currentQuestion,
    @Default(false) bool isCompletedSuccessfully,
    YesNoAnswer? pregnancy,
    CardiovascularDiseaseAnswers? cardiovascularDisease,
    YesNoAnswer? painInChest,
    YesNoAnswer? treatmentByTheDoctor,
    YesNoAnswer? stomachReductionDisease,
  }) = _MedicalFitnessState;

  factory MedicalFitnessState.fromJson(Map<String, dynamic> json) =>
      _$MedicalFitnessStateFromJson(json);
}
