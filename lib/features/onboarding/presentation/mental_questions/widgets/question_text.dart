import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text_with_accents/text_with_accents.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_test.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_test_type.dart';

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
        '${LocalizedTexts.who8Question.tr()}.',
        accents: [LocalizedTexts.lastTwoWeeks.tr()],
      );
    }

    if (currentTest?.type == MentalHealthTestType.phq15) {
      return TextWithAccents(
        '${LocalizedTexts.phq15Question.tr()}.',
        accents: [LocalizedTexts.pastFourWeeks.tr()],
      );
    }

    return TextWithAccents(
      '${LocalizedTexts.phq8Question.tr()}.',
      accents: [LocalizedTexts.lastTwoWeeks.tr()],
    );
  }
}
