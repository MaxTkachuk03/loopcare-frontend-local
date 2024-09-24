import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class AnswerExplanation extends StatelessWidget {
  final bool isCorrect;
  final String text;

  const AnswerExplanation({super.key, required this.isCorrect, required this.text});

  String get description => isCorrect ? LocalizedTexts.correct.tr() : LocalizedTexts.incorrect.tr();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isCorrect
                ? const CircleAvatar(
                    radius: 13,
                    backgroundColor: AppColors.greenRegular,
                    child: Icon(Icons.check, color: AppColors.white, size: 16),
                  )
                : const CircleAvatar(
                    radius: 13,
                    backgroundColor: AppColors.red,
                    child: Icon(Icons.close, color: AppColors.white, size: 16),
                  ),
            const SizedBox(width: 16.0),
            CustomText.bitter600(description, style: context.textTheme.bodyLarge),
          ],
        ),
        const SizedBox(height: 16),
        CustomText.w400(text, style: context.textTheme.bodyMedium),
      ],
    );
  }
}
