import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/answer_options_block.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_option.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/quizzes_controller.dart';

class AnswerOption extends StatelessWidget {
  final QuizzesController controller;
  final LessonQuestion question;
  final VoidCallback onNextPressed;
  final void Function(int id) onSelectOptionValue;
  final bool isEditable;

  const AnswerOption({
    super.key,
    required this.controller,
    required this.question,
    required this.onNextPressed,
    required this.onSelectOptionValue,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      onChanged: () => controller.isFormValid,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnswerOptionsBlock(
              selectedValues: controller.selectOptionValues.value,
              question: question,
              onSelected: (LessonQuestionOption value) => isEditable ? onSelectOptionValue(value.id) : null,
            ),
            Column(
              children: [
                CustomElevatedButton.blueFullWidth(
                  onPressed: onNextPressed,
                  label: LocalizedTexts.next,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
