part of 'medical_questions_bloc.dart';

@freezed
class MedicalQuestionsEvent with _$MedicalQuestionsEvent {
  const factory MedicalQuestionsEvent.resetData() = ResetData;

  const factory MedicalQuestionsEvent.pregnancyChanged(
    bool value,
  ) = PregnancyChanged;

  const factory MedicalQuestionsEvent.treatmentByTheDoctorChanged(
    bool value,
  ) = TreatmentByTheDoctorChanged;

  const factory MedicalQuestionsEvent.weightLossMedicationChanged(
    WeightLossMedicationAnswer value,
  ) = WeightLossMedicationChanged;

  const factory MedicalQuestionsEvent.medicationFuturePeriodChanged(
    MedicationFuturePeriodAnswer value,
  ) = MedicationFuturePeriodChanged;

  const factory MedicalQuestionsEvent.medicationPastPeriodChanged(
    MedicationPastPeriodAnswer value,
  ) = MedicationPastPeriodChanged;

  const factory MedicalQuestionsEvent.medicinesChanged(List<String> medicines) = MedicinesChanged;

  const factory MedicalQuestionsEvent.updateDisease(Diseases diseases, {required bool value}) = UpdateDisease;

  const factory MedicalQuestionsEvent.handleSexType(SexType sexType) = HandleSexType;

  const factory MedicalQuestionsEvent.handleBirthday(DateTime birthday) = HandleBirthday;
}
