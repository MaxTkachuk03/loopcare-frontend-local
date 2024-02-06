import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scoring_scale.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/quizzes_controller.dart';

class AnswerScale extends StatelessWidget {
  final QuizzesController controller;
  final LessonQuestion question;
  final VoidCallback onNextPressed;
  final void Function(int id) onSelectValue;
  final int? selectedScore;
  final String? feedbackText;
  final bool isEditable;

  const AnswerScale({
    super.key,
    required this.controller,
    required this.question,
    required this.onNextPressed,
    required this.onSelectValue,
    this.selectedScore,
    this.feedbackText,
    required this.isEditable,
  });

  void _onSelectedHandler(int value) {
    onSelectValue(value);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      onChanged: () => controller.isFormValid,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText.w400(question.introduction ?? '', style: context.textTheme.bodyLarge),
                const SizedBox(height: 28.0),
                CustomText.bitter600(question.question ?? '', style: context.textTheme.displayMedium),
                const SizedBox(height: 20.0),
                ScoringScale(
                  selectedColor: AppColors.greenRegular,
                  selectedScore: selectedScore,
                  onScoreTap: (int value) => isEditable ? _onSelectedHandler(value) : null,
                  scaleSize: question.lessonQuestionOptions.length,
                  labels: question.lessonQuestionOptionsLabels,
                  borderColor: AppColors.blueDarker,
                ),
                const SizedBox(height: 14.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.w600(
                      question.lowestText ?? LocalizedTexts.veryEasy.translation,
                      style: context.textTheme.bodySmall,
                    ),
                    CustomText.w600(
                      question.highestText ?? LocalizedTexts.veryHard.translation,
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
                if (feedbackText != null) const SizedBox(height: 24.0),
                if (feedbackText != null) CustomText.w600(feedbackText ?? '', style: context.textTheme.bodyLarge),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 32),
                ValueListenableBuilder<bool>(
                  valueListenable: controller.isEnableSend,
                  builder: (context, isEnableSend, _) {
                    return CustomElevatedButton.blueFullWidth(
                      onPressed: onNextPressed,
                      label: LocalizedTexts.next.tr(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
