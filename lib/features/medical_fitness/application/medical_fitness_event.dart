part of 'medical_fitness_bloc.dart';

@freezed
class MedicalFitnessEvent with _$MedicalFitnessEvent {
  const factory MedicalFitnessEvent.nextQuestion() = NextQuestion;

  const factory MedicalFitnessEvent.previousQuestion() = PreviousQuestion;

  const factory MedicalFitnessEvent.resetData() = ResetData;

  const factory MedicalFitnessEvent.pregnancyChanged(
    YesNoAnswer value,
  ) = PregnancyChanged;

  const factory MedicalFitnessEvent.cardiovascularDiseaseChanged(
    CardiovascularDiseaseAnswers value,
  ) = CardiovascularDiseaseChanged;

  const factory MedicalFitnessEvent.stomachReductionChanged(YesNoAnswer value) =
      StomachReductionChanged;

  const factory MedicalFitnessEvent.painInChestChanged(YesNoAnswer value) =
      PainInChestChanged;

  const factory MedicalFitnessEvent.treatmentByTheDoctorChanged(
    YesNoAnswer value,
  ) = TreatmentByTheDoctorChanged;

  const factory MedicalFitnessEvent.addPregnancyQuestion() =
      AddPregnancyQuestion;

  const factory MedicalFitnessEvent.removePregnancyQuestion() =
      RemovePregnancyQuestion;

  const factory MedicalFitnessEvent.handleSexType(SexType sexType) =
      HandleSexType;
}
