import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

enum WeightLossMedicationAnswer {
  no,
  mounjaro,
  ozempic,
  rybelsus,
  wegovy,
  otherBrand
}

extension WeightLossMedicationAnswerX on WeightLossMedicationAnswer {
  String get label {
    switch (this) {
      case WeightLossMedicationAnswer.no:
        return LocalizedTexts.no.tr().capitalize();
      case WeightLossMedicationAnswer.mounjaro:
        return LocalizedTexts.mounjaro.tr();
      case WeightLossMedicationAnswer.ozempic:
        return LocalizedTexts.ozempic.tr();
      case WeightLossMedicationAnswer.rybelsus:
        return LocalizedTexts.rybelsus.tr();
      case WeightLossMedicationAnswer.wegovy:
        return LocalizedTexts.wegovy.tr();
      case WeightLossMedicationAnswer.otherBrand:
        return LocalizedTexts.otherBrand.tr();
    }
  }
}

