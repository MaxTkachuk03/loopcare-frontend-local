import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    question.introduction ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 27.0,
                    horizontal: 24.0,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        question.question ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 20.0),
                      ScoringScale(
                        selectedScore: selectedScore,
                        onScoreTap: (int value) => isEditable ? _onSelectedHandler(value) : null,
                        scaleSize: question.lessonQuestionOptions.length,
                        labels: question.lessonQuestionOptionsLabels,
                        borderColor: AppColors.ff404040,
                      ),
                      const SizedBox(height: 14.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            question.lowestText ?? LocalizedTexts.veryEasy.translation,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            question.highestText ?? LocalizedTexts.veryHard.translation,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      if (feedbackText != null) const SizedBox(height: 24.0),
                      if (feedbackText != null)
                        Text(
                          feedbackText ?? '',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.blueDark,
                              ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  ValueListenableBuilder<bool>(
                    valueListenable: controller.isEnableSend,
                    builder: (context, isEnableSend, _) {
                      return ElevatedButton(
                        onPressed: onNextPressed,
                        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              backgroundColor: MaterialStateProperty.all(AppColors.blueDark),
                            ),
                        child: const Text(LocalizedTexts.next).tr(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
