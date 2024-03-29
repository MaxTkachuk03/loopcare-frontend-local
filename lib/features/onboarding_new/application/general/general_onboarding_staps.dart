part of 'general_onboarding_bloc.dart';

enum GeneralOnboardingStep {
  physical(AppColors.yellowRegular, AppColors.blueRegular, AppColors.yellowLightest, AppColors.yellowOffRegular, AppColors.yellowLighter, LocalizedTexts.physicalIntroTitle),
  medical(AppColors.blueRegular,  AppColors.coralRegular, AppColors.blueLightest, AppColors.blueOffRegular, AppColors.blueLighter, LocalizedTexts.medicalIntroTitle),
  mental(AppColors.orangeRegular, AppColors.blueRegular, AppColors.orangeLightest, AppColors.orangeOffRegular, AppColors.orangeLighter,LocalizedTexts.mentalHealth);

  const GeneralOnboardingStep(
    this.primaryColor,
    this.secondaryColor,
    this.background,
    this.alternativeBackgroundColor,
    this.appBarComponentsColor,
    this.title,
  );

  final Color primaryColor;
  final Color secondaryColor;
  final Color alternativeBackgroundColor;
  final Color background;
  final Color appBarComponentsColor;
  final String title;
}

enum PhysicalQuestionStep {
  intro(PhysicalIntroContent(key: ValueKey('physical_intro_content')), progress: 0),
  birthday(BirthdayContent(key: ValueKey('birthday_content')), progress: 1),
  ageExclusion(FailedAgeContent(key: ValueKey('age_exclusion_content')), progress: 1),
  gender(GenderContent(key: ValueKey('gender_content')), progress: 2),
  sex(SexContent(key: ValueKey('sex_content')), progress: 2),
  happiness(HappinessContent(key: ValueKey('happiness_content')), progress: 3),
  height(HeightContent(key: ValueKey('height_content')), progress: 4),
  weight(WeightContent(key: ValueKey('weight_content')), progress: 4),
  bmiExclusion(FailedBmiContent(key: ValueKey('failed_bmi_content')), progress: 4),
  result(CheckPassedContent(key: ValueKey('physical_passed_content')), progress: 5);

  const PhysicalQuestionStep(this.content, {this.progress = 0});

  final Widget content;
  final int progress;

  bool get hasProgressBar => this != intro;

  bool get isIntro => this == intro;

  bool get isExclusionOrResult => this == ageExclusion ||
      this == bmiExclusion ||
      this == result;
}

enum MedicalQuestionStep {
  intro(MedicalIntroContent(key: ValueKey('medical_intro_content')), progress: 0),
  pregnancy(PregnancyContent(key: ValueKey('pregnancy_content')), progress: 1),
  pregnancyExclusion(PregnancyFailedContent(key: ValueKey('pregnancy_failed_content')), progress: 1),
  medicines(MedicinesContent(key: ValueKey('medicines_content')), progress: 2),
  semaglutide(WeightLossMedicationContent(key: ValueKey('semaglutide_content')), progress: 3),
  semaglutideTakingPeriod(MedicationFuturePeriodContent(key: ValueKey('semaglutide_taking_period_content')), progress: 3),
  semaglutideTreatmentPeriod(MedicationPastPeriodContent(key: ValueKey('semaglutide_treatment_period_content')), progress: 3),
  semaglutideExplanation(MedicationExplanationContent(key: ValueKey('semaglutide_explanation_content')), progress: 3),
  secondaryForm(MedicalDiseaseContent(Diseases.obesity, key: ValueKey('obesity_content')), progress: 4),
  thyroidDisease(MedicalDiseaseContent(Diseases.thyroidDisease, key: ValueKey('thyroid_disease_content')), progress: 5),
  metabolicDisease(MedicalDiseaseContent(Diseases.metabolicDisease, key: ValueKey('metabolic_disease_content')), progress: 6),
  hypertension(MedicalDiseaseContent(Diseases.hypertension, key: ValueKey('hypertension_content')), progress: 7),
  cardiovascularDisease(MedicalDiseaseContent(Diseases.cardioVascularDisease, key: ValueKey('cardiovascular_disease_content')), progress: 8),
  stomachReduction(MedicalDiseaseContent(Diseases.stomachReductionDisease, key: ValueKey('stomach_reduction_content')), progress: 9),
  diabetesDisease(DiabetesDiseaseContent(key: ValueKey('diabetes_disease_content')), progress: 10),
  renalFailure(MedicalDiseaseContent(Diseases.renalFailure, key: ValueKey('renal_failure_content')), progress: 11),
  asthma(MedicalDiseaseContent(Diseases.asthma, key: ValueKey('asthma_content')), progress: 12),
  liverDisease(MedicalDiseaseContent(Diseases.liverDisease, key: ValueKey('liver_disease_content')), progress: 13),
  apneaSyndrome(MedicalDiseaseContent(Diseases.sleepApneaSyndrome, key: ValueKey('apnea_syndrome_content')), progress: 14),
  locomotorSystemDisease(MedicalDiseaseContent(Diseases.locomotorSystemDisease, key: ValueKey('locomotor_system_disease_content')), progress: 15),
  treatmentByTheDoctor(TreatmentByDoctorContent(key: ValueKey('treatment_by_the_doctor_content')), progress: 16),
  completedDisease(MedicalCheckFailedContent(key: ValueKey('medical_check_completed_disease_content')), progress: 16),
  result(MedicalCheckPassedContent(key: ValueKey('medical_check_result_content')), progress: 17);

  const MedicalQuestionStep(this.content, {this.progress = 0});

  final Widget content;
  final int progress;

  bool get hasProgressBar => this != intro;

  bool get isIntro => this == intro;

  bool get isExclusionOrResult => this == pregnancyExclusion ||
      this == semaglutideExplanation ||
      this == completedDisease ||
      this == result;
}

enum MentalQuestionStep {
  introStepOne(MentalHealthPreIntroContent(key: ValueKey('mental_intro_step_one_content'))),
  introStepTwo(MentalHealthIntroContent(key: ValueKey('mental_intro_step_two_content'))),
  test(MentalHealthQuestionContent(key: ValueKey('mental_test_content'))),
  testSummery(MentalCheckResultContent(key: ValueKey('mental_test_content'))),
  result(MentalCheckResultFinalContent(key: ValueKey('mental_health_result_content')));

  const MentalQuestionStep(this.content);

  final Widget content;

  bool get hasProgressBar => this != introStepOne;

  bool get isIntro => this == introStepOne;

  bool get isResult => this == testSummery || this == result;

  bool get isTests => this == testSummery || this == test;
}

const List<PhysicalQuestionStep> _defaultPhysicalQuestions = [
  PhysicalQuestionStep.intro,
  PhysicalQuestionStep.birthday,
  PhysicalQuestionStep.gender,
  PhysicalQuestionStep.sex,
  PhysicalQuestionStep.happiness,
  PhysicalQuestionStep.height,
  PhysicalQuestionStep.weight,
  PhysicalQuestionStep.result,
];

const List<MedicalQuestionStep> _defaultMedicalQuestions = [
  MedicalQuestionStep.intro,
  MedicalQuestionStep.medicines,
  MedicalQuestionStep.semaglutide,
  MedicalQuestionStep.secondaryForm,
  MedicalQuestionStep.thyroidDisease,
  MedicalQuestionStep.metabolicDisease,
  MedicalQuestionStep.hypertension,
  MedicalQuestionStep.cardiovascularDisease,
  MedicalQuestionStep.stomachReduction,
  MedicalQuestionStep.diabetesDisease,
  MedicalQuestionStep.renalFailure,
  MedicalQuestionStep.asthma,
  MedicalQuestionStep.liverDisease,
  MedicalQuestionStep.apneaSyndrome,
  MedicalQuestionStep.locomotorSystemDisease,
  MedicalQuestionStep.treatmentByTheDoctor,
  MedicalQuestionStep.result,
];

const List<MentalQuestionStep> _defaultMentalQuestions = [
  MentalQuestionStep.introStepOne,
  MentalQuestionStep.introStepTwo,
  MentalQuestionStep.test,
  MentalQuestionStep.testSummery,
  MentalQuestionStep.result,
];
