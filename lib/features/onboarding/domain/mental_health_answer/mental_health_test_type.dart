import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum MentalHealthTestType {
  who5,
  phq8,
  phq15,
  gad7;

  String get subTitle => switch (this) {
        who5 => LocalizedTexts.onboardingMentalResultSubText1.tr(),
        phq15 => LocalizedTexts.onboardingMentalResultSubText2.tr(),
        gad7 => LocalizedTexts.onboardingMentalResultSubText3.tr(),
        _ => '',
      };

  String get title => switch (this) {
        who5 => LocalizedTexts.onboardingGeneralWellBeingSummary.tr(),
        phq15 => LocalizedTexts.onboardingBodyAndMindBalanceSummary.tr(),
        gad7 || phq8 => LocalizedTexts.onboardingStateOfMindSummary.tr(),
      };
}
