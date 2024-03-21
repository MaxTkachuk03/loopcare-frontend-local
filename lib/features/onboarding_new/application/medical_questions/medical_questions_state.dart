part of 'medical_questions_bloc.dart';

@freezed
class MedicalQuestionsState with _$MedicalQuestionsState {
  const MedicalQuestionsState._();

  const factory MedicalQuestionsState({
    @Default(false) bool isCompletedSuccessfully,
    @Default(null) bool? pregnancy,
    @Default(null) WeightLossMedicationAnswer? weightLossMedication,
    @Default(null) MedicationPastPeriodAnswer? howLongTakeSemaglutideMedication,
    @Default(null) MedicationFuturePeriodAnswer? howLongSemaglutideTreatmentLast,
    @Default(null) bool? treatmentByTheDoctor,
    @Default([]) List<String> medicines,
    @Default({}) Map<Diseases, bool> diseases,
    @Default(null) int? age,
    @Default(null) SexType? sexType,
  }) = _MedicalFitnessData;

  factory MedicalQuestionsState.initial() => const MedicalQuestionsState();

  factory MedicalQuestionsState.fromJson(Map<String, dynamic> json) => _$MedicalQuestionsStateFromJson(json);

  List<Diseases> get listDiseasesEnabled {
    final Map<Diseases, bool> map = Map.from(diseases);
    return (map..removeWhere((key, value) => !value)).keys.toList();
  }

  bool get hasAtLeastOneDisease => diseases.values.any((value) => value);

  bool get containsDiabetesTypeI => diseases[Diseases.diabetesTypeI] ?? false;

  bool get containsDiabetesTypeII => diseases[Diseases.diabetesTypeII] ?? false;

  bool get containsDiabetesAnswer => diseases.containsKey(Diseases.diabetesTypeI) ||
  diseases.containsKey(Diseases.diabetesTypeII);

  bool? containsDisease(Diseases disease) => diseases[disease];

  bool markedDisease(Diseases disease) => diseases.containsKey(disease);

  String get diabetesType {
    bool containsDisease(Diseases disease) => diseases.keys.any((item) => item == disease);

    final hasTypeOneDiabete = containsDisease(Diseases.diabetesTypeI);
    final hasTypeTwoDiabete = containsDisease(Diseases.diabetesTypeII);

    if (!hasTypeOneDiabete && !hasTypeTwoDiabete) return LocalizedTexts.no;
    if (hasTypeOneDiabete) return Diseases.diabetesTypeI.name;
    if (hasTypeTwoDiabete) return Diseases.diabetesTypeII.name;

    return LocalizedTexts.no;
  }

  MedicalOnboarding get registrationData => MedicalOnboarding(
      pregnant: pregnancy ?? false,
      medicines: medicines,
      useSemaglutideMedication: weightLossMedication?.label ?? '',
      treatedByPsychiatrist: treatmentByTheDoctor ?? false,
      howLongTakeSemaglutideMedication: howLongTakeSemaglutideMedication?.label ?? '',
      howLongSemaglutideTreatmentLast: howLongSemaglutideTreatmentLast?.label ?? '',
      diabetes: diabetesType,
      obesity: diseases[Diseases.obesity] ?? false,
      thyroidDesease: diseases[Diseases.thyroidDisease] ?? false,
      metabolicDesease: diseases[Diseases.metabolicDisease] ?? false,
      hypertension: diseases[Diseases.hypertension] ?? false,
      cardiovascularDesease: diseases[Diseases.cardioVascularDisease] ?? false,
      stomachReduction: diseases[Diseases.stomachReductionDisease] ?? false,
      renalFailure: diseases[Diseases.renalFailure] ?? false,
      asthma: diseases[Diseases.asthma] ?? false,
      liverDesease: diseases[Diseases.liverDisease] ?? false,
      sleepApneaSyndrome: diseases[Diseases.sleepApneaSyndrome] ?? false,
      locomotorSystemDesease: diseases[Diseases.locomotorSystemDisease] ?? false,
    );
}

