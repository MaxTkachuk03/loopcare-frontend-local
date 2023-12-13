import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_input_limit_field.dart';
import 'package:loopcare_frontend/features/assignments/presentation/validators/answer_text_field_validator.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/questions_page_mode.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/quizzes_controller.dart';

class AnswerText extends StatelessWidget {
  final QuestionsPageMode mode;
  final QuizzesController controller;
  final LessonQuestion question;
  final VoidCallback onNextPressed;
  final VoidCallback onAnswerPressed;

  const AnswerText({
    super.key,
    required this.mode,
    required this.controller,
    required this.question,
    required this.onNextPressed,
    required this.onAnswerPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      onChanged: () => controller.isAnswerTextValid,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.question ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 30.0),
                mode.map(
                  askQuestion: (_) => SizedBox(
                    height: 200,
                    child: AnswerTextFormLimitTextField.answerText(controller),
                  ),
                  showAnswer: (_) => InkWell(
                    onTap: onAnswerPressed,
                    child: Text(
                      question.questionAnswer?.text ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.blueDark,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
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
            )
          ],
        ),
      ),
    );
  }
}

class AnswerTextFormLimitTextField extends AppLimitTextField {
  AnswerTextFormLimitTextField.answerText(QuizzesController controller, {super.key})
      : super(
          fieldKey: controller.answerTextFieldKey,
          focusNode: controller.answerTextFocusNode,
          controller: controller.answerTextController,
          validator: validateAnswerTextField,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          autovalidateMode: controller.answerTextAutoValidateMode,
          onChanged: (_) {},
          enforcedLimitCount: MaxLengthEnforcement.none,
          limitCount: 20000,
          minLines: 30,
          linesCount: 50,
          focusedColor: AppColors.blueMid,
          cursorColor: AppColors.darkGreen,
        );
}
