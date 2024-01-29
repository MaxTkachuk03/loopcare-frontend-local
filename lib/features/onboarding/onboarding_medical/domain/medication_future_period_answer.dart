import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum MedicationFuturePeriodAnswer { lessThanMonth, betweenSixAndTwelveMonths, twelveMonthsOrLonger }

extension MedicationFuturePeriodAnswerX on MedicationFuturePeriodAnswer {
  String get label {
    switch (this) {
      case MedicationFuturePeriodAnswer.lessThanMonth:
        return LocalizedTexts.lessThanMonth.tr(args: ['6']);
      case MedicationFuturePeriodAnswer.betweenSixAndTwelveMonths:
        return LocalizedTexts.betweenSixAndTwelveMonths.tr();
      case MedicationFuturePeriodAnswer.twelveMonthsOrLonger:
        return LocalizedTexts.twelveMonthsOrLonger.tr();
    }
  }
}
