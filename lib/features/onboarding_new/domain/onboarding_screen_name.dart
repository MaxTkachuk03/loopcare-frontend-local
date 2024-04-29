import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';

extension PhysicalQuestionStepScreenName on PhysicalQuestionStep {
  String get screenName => switch(this) {
    PhysicalQuestionStep.intro => 'Onboarding Basics Intro Screen',
    PhysicalQuestionStep.birthday => 'Onboarding Basics Birthday Screen',
    PhysicalQuestionStep.ageExclusion => 'Onboarding Basics Age Exclusion Screen',
    PhysicalQuestionStep.gender => 'Onboarding Basics Gender Screen',
    PhysicalQuestionStep.sex => 'Onboarding Basics Sex Screen',
    PhysicalQuestionStep.happiness => 'Onboarding Basics Happiness Screen',
    PhysicalQuestionStep.height => 'Onboarding Basics Height Screen',
    PhysicalQuestionStep.weight => 'Onboarding Basics Weight Screen',
    PhysicalQuestionStep.bmiExclusion => 'Onboarding Basics Bmi Exclusion Screen',
    PhysicalQuestionStep.result => 'Onboarding Basics Completed Screen',
  };
}

extension MedicalQuestionStepScreenName on MedicalQuestionStep {
  String get screenName => switch(this) {
    MedicalQuestionStep.intro => 'Onboarding Medical Intro Screen',
    MedicalQuestionStep.pregnancy => 'Onboarding Medical Pregnancy Screen',
    MedicalQuestionStep.pregnancyExclusion => 'Onboarding Medical Pregnancy Exclusion Screen',
    MedicalQuestionStep.medicines => 'Onboarding Medical Medicine Screen',
    MedicalQuestionStep.semaglutide => 'Onboarding Medical Semaglutide Screen',
    MedicalQuestionStep.semaglutideTakingPeriod => 'Onboarding Medical Semaglutide Taking Period Screen',
    MedicalQuestionStep.semaglutideTreatmentPeriod => 'Onboarding Medical Semaglutide Treatment Period Screen',
    MedicalQuestionStep.semaglutideExplanation => 'Onboarding Medical Semaglutide Explanation Screen',
    MedicalQuestionStep.secondaryForm => 'Onboarding Medical Secondary Form Screen',
    MedicalQuestionStep.thyroidDisease => 'Onboarding Medical Thyroid Disease Screen',
    MedicalQuestionStep.metabolicDisease => 'Onboarding Medical Metabolic Disease Screen',
    MedicalQuestionStep.hypertension => 'Onboarding Medical Hypertension Screen',
    MedicalQuestionStep.cardiovascularDisease => 'Onboarding Medical Cardiovascular Disease Screen',
    MedicalQuestionStep.stomachReduction => 'Onboarding Medical Stomach Reduction Screen',
    MedicalQuestionStep.diabetesDisease => 'Onboarding Medical Diabetes Screen',
    MedicalQuestionStep.renalFailure => 'Onboarding Medical Renal Failure Screen',
    MedicalQuestionStep.asthma => 'Onboarding Medical Asthma Screen',
    MedicalQuestionStep.liverDisease => 'Onboarding Medical Liver Disease Screen',
    MedicalQuestionStep.apneaSyndrome => 'Onboarding Medical Apnea Screen',
    MedicalQuestionStep.locomotorSystemDisease => 'Onboarding Medical Locomotor Screen',
    MedicalQuestionStep.treatmentByTheDoctor => 'Onboarding Medical Psychologist Psychiatrist Screen',
    MedicalQuestionStep.completedDisease => 'Onboarding Medical Completed Disease Screen',
    MedicalQuestionStep.result => 'Onboarding Medical Completed Screen',
  };
}

extension MentalQuestionStepScreenName on MentalQuestionStep {
  String getScreenName(String testName) => switch(this) {
    MentalQuestionStep.introStepOne => 'Onboarding Mental Health Intro Screen',
    MentalQuestionStep.introStepTwo => 'Onboarding Mental Health Description Screen',
    MentalQuestionStep.test => 'Onboarding Mental Health Test $testName Question Screen',
    MentalQuestionStep.testSummery => 'Onboarding Mental Health Test $testName Result Screen',
    MentalQuestionStep.result => 'Onboarding Mental Health Completed Screen',
    MentalQuestionStep.resultFailed => 'Onboarding Mental Health Exclusion Screen',
  };
}
