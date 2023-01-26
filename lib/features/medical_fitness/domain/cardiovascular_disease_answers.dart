import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

enum CardiovascularDiseaseAnswers {
  yes,
  no,
  noBut
}

extension CardiovascularDiseaseAnswersX on CardiovascularDiseaseAnswers {
  String get label {
    switch (this) {
      case CardiovascularDiseaseAnswers.yes:
        return LocalizedTexts.yes.tr().capitalize();
      case CardiovascularDiseaseAnswers.no:
        return LocalizedTexts.no.tr().capitalize();
      case CardiovascularDiseaseAnswers.noBut:
        return LocalizedTexts.noCardiovascularDiseaseBut.tr().capitalize();
    }
  }
}

