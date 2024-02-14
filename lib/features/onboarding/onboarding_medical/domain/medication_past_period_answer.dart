import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum MedicationPastPeriodAnswer {
  lessThanMonth,
  lessThanThreeMonths,
  lessThanSixMonths,
  lessThanNineMonths,
  lessThanTwelveMonths,
  twelveMonthsOrLonger
}

extension MedicationPastPeriodAnswerX on MedicationPastPeriodAnswer {
  String get label {
    switch (this) {
      case MedicationPastPeriodAnswer.lessThanMonth:
        return LocalizedTexts.lessThanMonth.tr();
      case MedicationPastPeriodAnswer.lessThanThreeMonths:
        return LocalizedTexts.lessThanCertainMonths.tr(namedArgs: {
          'number': '3',
        });
      case MedicationPastPeriodAnswer.lessThanSixMonths:
        return LocalizedTexts.lessThanCertainMonths.tr(namedArgs: {
          'number': '6',
        });
      case MedicationPastPeriodAnswer.lessThanNineMonths:
        return LocalizedTexts.lessThanCertainMonths.tr(namedArgs: {
          'number': '9',
        });
      case MedicationPastPeriodAnswer.lessThanTwelveMonths:
        return LocalizedTexts.lessThanCertainMonths.tr(namedArgs: {
          'number': '12',
        });
      case MedicationPastPeriodAnswer.twelveMonthsOrLonger:
        return LocalizedTexts.twelveMonthsOrLonger.tr();
    }
  }
}
