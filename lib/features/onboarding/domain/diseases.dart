import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

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
    Diseases.cardioVascularDisease => LocalizedTexts.cardioVascularDisease,
    Diseases.stomachReductionDisease => LocalizedTexts.stomachReductionDisease,
    Diseases.obesity => LocalizedTexts.obesity,
    Diseases.thyroidDisease => LocalizedTexts.thyroidDisease,
    Diseases.metabolicDisease => LocalizedTexts.metabolicDisease,
    Diseases.hypertension => LocalizedTexts.hypertension,
    Diseases.diabetesTypeI => LocalizedTexts.diabetesTypeI,
    Diseases.diabetesTypeII => LocalizedTexts.diabetesTypeII,
    Diseases.renalFailure => LocalizedTexts.renalFailure,
    Diseases.asthma => LocalizedTexts.asthma,
    Diseases.liverDisease => LocalizedTexts.liverDisease,
    Diseases.sleepApneaSyndrome => LocalizedTexts.sleepApneaSyndrome,
    Diseases.locomotorSystemDisease => LocalizedTexts.locomotorSystemDisease,
  };

  String get question {
    if (this == Diseases.obesity) {
      return LocalizedTexts.obesityQuestion;
    } else if (this == Diseases.cardioVascularDisease) {
      return LocalizedTexts.cardiovascularDiseaseQuestion;
    } else if (this == Diseases.stomachReductionDisease) {
      return LocalizedTexts.stomachReductionQuestion;
    } else if (this == Diseases.thyroidDisease) {
      return LocalizedTexts.thyroidDiseaseQuestion;
    } else if (this == Diseases.metabolicDisease) {
      return LocalizedTexts.metabolicDiseaseQuestion;
    } else if (this == Diseases.hypertension) {
      return LocalizedTexts.hypertensionQuestion;
    } else if (this == Diseases.diabetesTypeI || this == Diseases.diabetesTypeII) {
      return LocalizedTexts.diabetesQuestion;
    } else if (this == Diseases.renalFailure) {
      return LocalizedTexts.renalFailureQuestion;
    } else if (this == Diseases.asthma) {
      return LocalizedTexts.asthmaQuestion;
    } else if (this == Diseases.liverDisease) {
      return LocalizedTexts.liverDiseaseQuestion;
    } else if (this == Diseases.sleepApneaSyndrome) {
      return LocalizedTexts.sleepApneaSyndromeQuestion;
    } else if (this == Diseases.locomotorSystemDisease) {
      return LocalizedTexts.locomotorSystemDiseaseQuestion;
    } else {
      return '';
    }
  }
}