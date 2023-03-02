import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum ConsentConfirmationAnswers {
  haveToAsk,
  yes,
  no,
}

extension ConsentConfirmationAnswersX on ConsentConfirmationAnswers {
  String get label {
    switch (this) {
      case ConsentConfirmationAnswers.haveToAsk:
        return LocalizedTexts.iStillHaveToAskConsent.tr();
      case ConsentConfirmationAnswers.yes:
        return LocalizedTexts.yesIHaveConsent.tr();
      case ConsentConfirmationAnswers.no:
        return LocalizedTexts.noIWasNotGratedConsent.tr();
    }
  }
}
