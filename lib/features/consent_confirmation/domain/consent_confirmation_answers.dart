import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

enum ConsentConfirmationAnswers {
  haveToAsk,
  yes,
  no
}

extension ConsentConfirmationAnswersX on ConsentConfirmationAnswers {
  String get label {
    switch (this) {
      case ConsentConfirmationAnswers.haveToAsk:
        return LocalizedTexts.iStillHaveToAskConsent.tr().capitalize();
      case ConsentConfirmationAnswers.yes:
        return LocalizedTexts.yesIHaveConsent.tr().capitalize();
      case ConsentConfirmationAnswers.no:
        return LocalizedTexts.noIWasNotGratedConsent.tr().capitalize();
    }
  }
}

