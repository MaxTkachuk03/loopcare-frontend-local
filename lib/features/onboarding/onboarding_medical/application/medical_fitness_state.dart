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
    @Default(null) MedicationPastPeriodAnswer? howLongTakeSemaglutideMedication,
    @Default(null) MedicationFuturePeriodAnswer? howLongSemaglutideTreatmentLast,
    @Default(null) YesNoAnswer? treatmentByTheDoctor,
    @Default([]) List<String> medicines,
    @Default({}) Set<DiseasesState> diseasesList,
    @Default(null) int? age,
    @Default(null) SexType? sexType,
  }) = _MedicalFitnessData;

  List<DiseasesState> get listDiseasesEnabled => diseasesList.where((item) => item.enable).toList();

  bool get hasAtLeastOneDisease => diseasesList.where((item) => item.enable).isNotEmpty;

  bool get isTreatedByPsychologist => treatmentByTheDoctor == YesNoAnswer.yes;

  bool get hasCardiovascularDisease =>
      diseasesList.where((item) => item.diseases == Diseases.cardioVascularDisease && item.enable).isNotEmpty;

  bool containsDisease(Diseases diseases) =>
      diseasesList.where((item) => item.diseases == diseases).isNotEmpty;

  DiseasesState getContainedDisease(Diseases diseases) =>
      diseasesList.where((item) => item.diseases == diseases).first;

  String get diabetesType {
    final hasTypeOneDiabete = containsDisease(Diseases.diabetesTypeI);
    final hasTypeTwoDiabete = containsDisease(Diseases.diabetesTypeII);

    if (!hasTypeOneDiabete && !hasTypeTwoDiabete) return LocalizedTexts.no;
    if (hasTypeOneDiabete) return Diseases.diabetesTypeI.name;
    if (hasTypeTwoDiabete) return Diseases.diabetesTypeII.name;

    return LocalizedTexts.no;
  }

  MedicalOnboarding registrationData() {
    final Map<String, bool> diseases = {};

    for (var e in diseasesList) {
      diseases[e.diseases.label] = e.enable;
    }

    final medicalOnboarding = MedicalOnboarding(
      pregnant: pregnancy?.boolValue ?? false,
      medicines: medicines,
      useSemaglutideMedication: weightLossMedication?.label ?? '',
      treatedByPsychiatrist: treatmentByTheDoctor?.boolValue ?? false,
      howLongTakeSemaglutideMedication: howLongTakeSemaglutideMedication?.label ?? '',
      howLongSemaglutideTreatmentLast: howLongSemaglutideTreatmentLast?.label ?? '',
      diabetes: diabetesType,
      obesity: diseases['obesity'] ?? false,
      thyroidDesease: diseases['thyroidDesease'] ?? false,
      metabolicDesease: diseases['metabolicDesease'] ?? false,
      hypertension: diseases['hypertension'] ?? false,
      cardiovascularDesease: diseases['cardioVascularDisease'] ?? false,
      stomachReduction: diseases['stomachReductionDisease'] ?? false,
      renalFailure: diseases['renalFailure'] ?? false,
      asthma: diseases['asthma'] ?? false,
      liverDesease: diseases['liverDesease'] ?? false,
      sleepApneaSyndrome: diseases['sleepApneaSyndrome'] ?? false,
      locomotorSystemDesease: diseases['locomotorSystemDesease'] ?? false,
    );

    return medicalOnboarding;
  }

  factory MedicalFitnessData.fromJson(Map<String, dynamic> json) => _$MedicalFitnessDataFromJson(json);
}
