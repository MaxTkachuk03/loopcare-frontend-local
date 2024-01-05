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

  String get label {
    switch (this) {
      case cardioVascularDisease:
        return LocalizedTexts.cardioVascularDisease;
      case stomachReductionDisease:
        return LocalizedTexts.stomachReductionDisease;
      case obesity:
        return LocalizedTexts.obesity;
      case thyroidDisease:
        return LocalizedTexts.thyroidDisease;
      case metabolicDisease:
        return LocalizedTexts.metabolicDisease;
      case hypertension:
        return LocalizedTexts.hypertension;
      case diabetesTypeI:
        return LocalizedTexts.diabetesTypeI;
      case diabetesTypeII:
        return LocalizedTexts.diabetesTypeII;
      case renalFailure:
        return LocalizedTexts.renalFailure;
      case asthma:
        return LocalizedTexts.asthma;
      case liverDisease:
        return LocalizedTexts.liverDisease;
      case sleepApneaSyndrome:
        return LocalizedTexts.sleepApneaSyndrome;
      case locomotorSystemDisease:
        return LocalizedTexts.locomotorSystemDisease;
    }
  }

  final int number;
  final String value;
}
