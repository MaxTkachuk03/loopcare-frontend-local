import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/content_select_answer.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SelectFeedback extends StatelessWidget {
  final InteractiveLessonChunkComponentSingleSelectWithFeedback component;
  final ContentSelectAnswer? selectedAnswer;

  const SelectFeedback({super.key, required this.component, required this.selectedAnswer});

  bool get hasFeedback => component.content.feedbackCorrect != null;

  bool get hasAnswer => selectedAnswer != null;

  bool get hasCorrectAnswer => selectedAnswer?.isCorrect ?? false;

  String get feedbackTitle => hasCorrectAnswer
      ? LocalizedTexts.interactiveLessonsCorrectFeedbackTitle.tr()
      : LocalizedTexts.interactiveLessonsIncorrectFeedbackTitle.tr();

  @override
  Widget build(BuildContext context) {
    if (!hasFeedback || !hasAnswer) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 13,
                backgroundColor: hasCorrectAnswer ? AppColors.greenRegular : AppColors.red,
                child: Icon(
                  hasCorrectAnswer ? Icons.check : Icons.close,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 16.0),
              CustomText.bitter600(feedbackTitle, style: context.textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 12),
          CustomText(
            hasCorrectAnswer
                ? component.content.feedbackCorrect ?? ''
                : component.content.feedbackIncorrect ?? '',
            textAlign: TextAlign.left,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
