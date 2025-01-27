import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/content_select_answer.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/select_content.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SelectFeedback extends StatelessWidget {
  final SelectContent content;
  final ContentSelectAnswer? selectedAnswer;
  final List<ContentSelectAnswer>? selectedAnswers;

  const SelectFeedback(
      {super.key,
      required this.content,
      this.selectedAnswer,
      this.selectedAnswers});

  bool get hasFeedback => content.feedbackCorrect != null;

  bool get hasAnswer => selectedAnswer != null || selectedAnswers != null;

  bool get hasCorrectAnswer => selectedAnswer?.isCorrect ?? false;

  bool get correctAnswers {
    if (selectedAnswers == null) return false;

    if (selectedAnswers!.length <= 1) {
      return false;
    }

    final isCorrectFromAnswer =
        selectedAnswers?.where((t) => t.isCorrect == true).toList();

    final isCorrectFromContent =
        content.answers.where((t) => t.isCorrect == true).toList();

    final isCorrect =
        isCorrectFromContent.length == isCorrectFromAnswer!.length &&
            selectedAnswers!.length == isCorrectFromContent.length;

    return isCorrect;
  }

  String get feedbackTitle => hasCorrectAnswer || correctAnswers
      ? LocalizedTexts.interactiveLessonsCorrectFeedbackTitle.tr()
      : LocalizedTexts.interactiveLessonsIncorrectFeedbackTitle.tr();

  @override
  Widget build(BuildContext context) {
    if (!hasFeedback || !hasAnswer) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 13,
                backgroundColor: hasCorrectAnswer || correctAnswers
                    ? AppColors.greenRegular
                    : AppColors.red,
                child: Icon(
                  hasCorrectAnswer || correctAnswers
                      ? Icons.check
                      : Icons.close,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 16.0),
              CustomText.bitter600(feedbackTitle,
                  style: context.textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 12),
          CustomText(
            hasCorrectAnswer || correctAnswers
                ? content.feedbackCorrect ?? ''
                : content.feedbackIncorrect ?? '',
            textAlign: TextAlign.left,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
