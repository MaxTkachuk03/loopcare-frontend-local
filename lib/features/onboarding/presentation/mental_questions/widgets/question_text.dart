import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text_with_accents/text_with_accents.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_test.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_test_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class QuestionText extends StatelessWidget {
  const QuestionText({
    super.key,
    required this.currentTest,
  });

  final MentalHealthTest? currentTest;

  @override
  Widget build(BuildContext context) {
    if (currentTest == null) return const SizedBox.shrink();

    if (currentTest?.type == MentalHealthTestType.who5) {
      return TextWithAccents(
        LocalizedTexts.onboardingWho8Question.tr(),
        accents: [LocalizedTexts.onboardingLastTwoWeeks.tr()],
      );
    }

    if (currentTest?.type == MentalHealthTestType.phq15) {
      return TextWithAccents(
        LocalizedTexts.onboardingPhq15Question.tr(),
        accents: [LocalizedTexts.onboardingPastFourWeeks.tr()],
      );
    }

    return TextWithAccents(
      LocalizedTexts.onboardingPhq8Question.tr(),
      accents: [LocalizedTexts.onboardingLastTwoWeeks.tr()],
    );
  }
}
