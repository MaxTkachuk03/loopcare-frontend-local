part of 'medical_fitness_bloc.dart';

@freezed
class MedicalFitnessState with _$MedicalFitnessState {
  const MedicalFitnessState._();

  factory MedicalFitnessState.initial() => MedicalFitnessState(
        currentQuestion: medicalFitnessQuestions[0],
      );

  const factory MedicalFitnessState({
    required String currentQuestion,
    @Default(false) bool isCompletedSuccessfully,
    YesNoAnswer? pregnancy,
    CardiovascularDiseaseAnswers? cardiovascularDisease,
    WeightLossMedicationAnswer? weightLossMedication,
    YesNoAnswer? painInChest,
    YesNoAnswer? treatmentByTheDoctor,
    YesNoAnswer? stomachReductionDisease,
    int? age,
    SexType? sexType,
  }) = _MedicalFitnessState;

  factory MedicalFitnessState.fromJson(Map<String, dynamic> json) =>
      _$MedicalFitnessStateFromJson(json);
}
