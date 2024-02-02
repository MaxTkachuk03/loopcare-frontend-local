part of 'medical_fitness_bloc.dart';

@freezed
class MedicalFitnessState with _$MedicalFitnessState {
  const factory MedicalFitnessState.initial(MedicalFitnessData data) = MedicalFitnessStateInitial;

  const factory MedicalFitnessState.updated(MedicalFitnessData data) = MedicalFitnessStateUpdated;

  factory MedicalFitnessState.fromJson(Map<String, dynamic> json) => _$MedicalFitnessStateFromJson(json);
}

@freezed
class MedicalFitnessData with _$MedicalFitnessData {
  const MedicalFitnessData._();

  const factory MedicalFitnessData({
    @Default('intro') String currentQuestion,
    @Default(false) bool isCompletedSuccessfully,
    @Default(null) YesNoAnswer? pregnancy,
    @Default(null) WeightLossMedicationAnswer? weightLossMedication,
    @Default(null) YesNoAnswer? treatmentByTheDoctor,
    @Default([]) List<String> medicines,
    @Default({}) Set<Diseases> diseasesList,
    @Default(null) int? age,
    @Default(null) SexType? sexType,
  }) = _MedicalFitnessData;

  bool get hasAtLeastOneDisease => diseasesList.isNotEmpty;

  bool get isTreatedByPsychologist => treatmentByTheDoctor == YesNoAnswer.yes;

  bool get hasCardiovascularDisease => diseasesList.contains(Diseases.cardioVascularDisease);

  factory MedicalFitnessData.fromJson(Map<String, dynamic> json) => _$MedicalFitnessDataFromJson(json);
}
