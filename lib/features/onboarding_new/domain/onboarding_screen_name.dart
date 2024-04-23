import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';

extension PhysicalQuestionStepScreenName on PhysicalQuestionStep {
  String get screenName => switch (this) {
        PhysicalQuestionStep.intro => 'Physical Intro Screen',
        PhysicalQuestionStep.birthday => 'Birthday Screen',
        PhysicalQuestionStep.ageExclusion => 'Birthday Exclusion Screen',
        PhysicalQuestionStep.gender => 'Gender Screen',
        PhysicalQuestionStep.sex => 'Sex Screen',
        PhysicalQuestionStep.happiness => 'Happiness Screen',
        PhysicalQuestionStep.height => 'Height Screen',
        PhysicalQuestionStep.weight => 'Weight Screen',
        PhysicalQuestionStep.bmiExclusion => 'Bmi Exclusion Screen',
        PhysicalQuestionStep.result => 'Physical Check Result Screen',
      };
}

extension MedicalQuestionStepScreenName on MedicalQuestionStep {
  String get screenName => switch (this) {
        MedicalQuestionStep.intro => 'Medical Intro Screen',
        MedicalQuestionStep.pregnancy => 'Pregnancy Screen',
        MedicalQuestionStep.pregnancyExclusion => 'Pregnancy Exclusion Screen',
        MedicalQuestionStep.medicines => 'Medicinesn Screen',
        MedicalQuestionStep.semaglutide => 'Weight Loss Medication Screen',
        MedicalQuestionStep.semaglutideTakingPeriod => 'Medication Check Passed Screen',
        MedicalQuestionStep.semaglutideTreatmentPeriod => 'Medication Past Period Screen',
        MedicalQuestionStep.semaglutideExplanation => 'Medication Explanation',
        MedicalQuestionStep.secondaryForm => 'Obesity Screen',
        MedicalQuestionStep.thyroidDisease => 'Thyroid Disease Screen',
        MedicalQuestionStep.metabolicDisease => 'Metabolic Disease Screen',
        MedicalQuestionStep.hypertension => 'Hypertension Screen',
        MedicalQuestionStep.cardiovascularDisease => 'Cardiovascular Disease Screen',
        MedicalQuestionStep.stomachReduction => 'Stomach Reduction Screen',
        MedicalQuestionStep.diabetesDisease => 'Diabetes Disease Screen',
        MedicalQuestionStep.renalFailure => 'Renal Failure Screen',
        MedicalQuestionStep.asthma => 'Asthma Screen',
        MedicalQuestionStep.liverDisease => 'Liver Disease Screen',
        MedicalQuestionStep.apneaSyndrome => 'Apnea Syndrome Screen',
        MedicalQuestionStep.locomotorSystemDisease => 'Locomotor System Disease Screen',
        MedicalQuestionStep.treatmentByTheDoctor => 'Treatment By The Doctor Screen',
        MedicalQuestionStep.completedDisease => 'Completed With Disease Screen',
        MedicalQuestionStep.result => 'Medical Check Result Screen',
      };
}

extension MentalQuestionStepScreenName on MentalQuestionStep {
  String getScreenName(String testName) => switch (this) {
        MentalQuestionStep.introStepOne => 'Mental Health Intro Screen',
        MentalQuestionStep.introStepTwo => 'Mental Health Description Screen',
        MentalQuestionStep.test => 'Mental Health Question $testName Screen',
        MentalQuestionStep.testSummery => 'Mental Check $testName Result Screen',
        MentalQuestionStep.result => 'Medical Check Result Screen',
        MentalQuestionStep.resultFailed => 'Mental Health Exclusion screen',
      };
}
