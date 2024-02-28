part of 'medical_fitness_bloc.dart';

@freezed
class MedicalFitnessEvent with _$MedicalFitnessEvent {
  const factory MedicalFitnessEvent.nextQuestion() = NextQuestion;

  const factory MedicalFitnessEvent.previousQuestion() = PreviousQuestion;

  const factory MedicalFitnessEvent.resetData() = ResetData;

  const factory MedicalFitnessEvent.pregnancyChanged(
    YesNoAnswer value,
  ) = PregnancyChanged;

  const factory MedicalFitnessEvent.treatmentByTheDoctorChanged(
    YesNoAnswer value,
  ) = TreatmentByTheDoctorChanged;

  const factory MedicalFitnessEvent.weightLossMedicationChanged(
    WeightLossMedicationAnswer value,
  ) = WeightLossMedicationChanged;

  const factory MedicalFitnessEvent.medicinesChanged(List<String> medicines) = MedicinesChanged;

  const factory MedicalFitnessEvent.addDisease(Diseases value) = AddDisease;

  const factory MedicalFitnessEvent.removeDisease(Diseases value) = RemoveDisease;

  const factory MedicalFitnessEvent.handleSexType(SexType sexType) = HandleSexType;

  const factory MedicalFitnessEvent.handleBirthday(DateTime birthday) = HandleBirthday;
}
