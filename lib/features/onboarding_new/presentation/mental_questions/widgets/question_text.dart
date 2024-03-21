import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/mental_health_answer/mental_health_test.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/mental_health_answer/mental_health_test_type.dart';

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
      return RichText(
        text: TextSpan(
          text: LocalizedTexts.who8Question.tr(),
          style: context.textTheme.bodyMedium,
          children: [
            TextSpan(
              text: ' ${LocalizedTexts.lastTwoWeeks.tr()}.',
              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    if (currentTest?.type == MentalHealthTestType.phq15) {
      return RichText(
        text: TextSpan(
          text: LocalizedTexts.duringThe.tr(),
          style: context.textTheme.bodyMedium,
          children: [
            TextSpan(
              text: ' ${LocalizedTexts.pastFourWeeks.tr()}, ',
              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: '${LocalizedTexts.phq15Question.tr()}?',
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    if (currentTest?.type == MentalHealthTestType.gad7) {
      return RichText(
        text: TextSpan(
          text: LocalizedTexts.overThe.tr(),
          style: context.textTheme.bodyMedium,
          children: [
            TextSpan(
              text: ' ${LocalizedTexts.lastTwoWeeks.tr()}, ',
              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: '${LocalizedTexts.phq8Question.tr()}?',
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return RichText(
      text: TextSpan(
        text: LocalizedTexts.overThe.tr(),
        style: context.textTheme.bodyMedium,
        children: [
          TextSpan(
            text: ' ${LocalizedTexts.lastTwoWeeks.tr()}, ',
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: LocalizedTexts.phq8Question.tr(),
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
