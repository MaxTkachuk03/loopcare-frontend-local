import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_input_limit_field.dart';
import 'package:loopcare_frontend/features/assignments/presentation/validators/answer_text_field_validator.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/quizzes_controller.dart';

class AnswerText extends StatelessWidget {
  final QuizzesController controller;
  final LessonQuestion question;
  final Function(int lessonId) onNextPressed;

  const AnswerText({
    super.key,
    required this.controller,
    required this.question,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      onChanged: () => controller.isAnswerTextValid,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CustomText.bitter600(question.question ?? '', style: context.textTheme.displayMedium),
                const SizedBox(height: 28.0),
                CustomText.w400(question.extraInstruction, style: context.textTheme.bodyMedium),
                const SizedBox(height: 28.0),
                SizedBox(
                  height: 200,
                  child: AnswerTextFormLimitTextField.answerText(controller),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 32),
                CustomElevatedButton.blueFullWidth(
                  onPressed: () => controller.isOpenTextValid ? onNextPressed(question.lessonId) : null,
                  label: LocalizedTexts.next.tr(),
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
          hintText: '',
        );
}
