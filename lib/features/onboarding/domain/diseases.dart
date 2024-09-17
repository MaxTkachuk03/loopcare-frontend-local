import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum Diseases {
  cardioVascularDisease(1, 'cardiovascular disease'),
  stomachReductionDisease(2, 'stomach reduction disease'),
  obesity(3, 'obesity disease'),
  thyroidDisease(4, 'thyroid disease'),
  metabolicDisease(5, 'metabolic disease'),
  hypertension(6, 'hypertension'),
  diabetesTypeI(7, 'diabetes type I'),
  diabetesTypeII(8, 'diabetes type II'),
  renalFailure(9, 'renal failure'),
  asthma(10, 'asthma'),
  liverDisease(11, 'liver disease'),
  sleepApneaSyndrome(12, 'sleep apnea syndrome'),
  locomotorSystemDisease(13, 'locomotor system disease');

  const Diseases(this.number, this.value);

  bool get isDiabetes => this == diabetesTypeI || this == diabetesTypeII;

  final int number;
  final String value;
}

extension DiseasesExtension on Diseases {
  String get label => switch (this) {
        Diseases.cardioVascularDisease => LocalizedTexts.onboardingCardioVascularDisease,
        Diseases.stomachReductionDisease => LocalizedTexts.onboardingStomachReductionDisease,
        Diseases.obesity => LocalizedTexts.onboardingObesity,
        Diseases.thyroidDisease => LocalizedTexts.onboardingThyroidDisease,
        Diseases.metabolicDisease => LocalizedTexts.onboardingMetabolicDisease,
        Diseases.hypertension => LocalizedTexts.onboardingHypertension,
        Diseases.diabetesTypeI => LocalizedTexts.onboardingDiabetesTypeI,
        Diseases.diabetesTypeII => LocalizedTexts.onboardingDiabetesTypeII,
        Diseases.renalFailure => LocalizedTexts.onboardingRenalFailure,
        Diseases.asthma => LocalizedTexts.onboardingAsthma,
        Diseases.liverDisease => LocalizedTexts.onboardingLiverDisease,
        Diseases.sleepApneaSyndrome => LocalizedTexts.onboardingSleepApneaSyndrome,
        Diseases.locomotorSystemDisease => LocalizedTexts.onboardingLocomotorSystemDisease,
      };

  String get question {
    if (this == Diseases.obesity) {
      return LocalizedTexts.onboardingObesityQuestion;
    } else if (this == Diseases.cardioVascularDisease) {
      return LocalizedTexts.onboardingCardiovascularDiseaseQuestion;
    } else if (this == Diseases.stomachReductionDisease) {
      return LocalizedTexts.onboardingStomachReductionQuestion;
    } else if (this == Diseases.thyroidDisease) {
      return LocalizedTexts.onboardingThyroidDiseaseQuestion;
    } else if (this == Diseases.metabolicDisease) {
      return LocalizedTexts.onboardingMetabolicDiseaseQuestion;
    } else if (this == Diseases.hypertension) {
      return LocalizedTexts.onboardingHypertensionQuestion;
    } else if (this == Diseases.diabetesTypeI || this == Diseases.diabetesTypeII) {
      return LocalizedTexts.onboardingDiabetesQuestion;
    } else if (this == Diseases.renalFailure) {
      return LocalizedTexts.onboardingRenalFailureQuestion;
    } else if (this == Diseases.asthma) {
      return LocalizedTexts.onboardingAsthmaQuestion;
    } else if (this == Diseases.liverDisease) {
      return LocalizedTexts.onboardingLiverDiseaseQuestion;
    } else if (this == Diseases.sleepApneaSyndrome) {
      return LocalizedTexts.onboardingSleepApneaSyndromeQuestion;
    } else if (this == Diseases.locomotorSystemDisease) {
      return LocalizedTexts.onboardingLocomotorSystemDiseaseQuestion;
    } else {
      return '';
    }
  }
}
