import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/quizzes/presentation/widgets/correct_checkmark.dart';

class CorrectIncorrectExplanation extends StatelessWidget {
  final bool isCorrect;
  final String text;

  const CorrectIncorrectExplanation({
    super.key,
    required this.isCorrect,
    required this.text,
  });

  String get description =>
      isCorrect ? LocalizedTexts.correct.translation : LocalizedTexts.incorrect.translation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            isCorrect
                ? const CorrectCheckmark()
                : SizedBox(width: 20, height: 20, child: AppIcons.crossOutlined),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
