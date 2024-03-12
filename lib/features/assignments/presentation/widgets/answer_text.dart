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

class AnswerText extends StatefulWidget {
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
  State<AnswerText> createState() => _AnswerTextState();
}

class _AnswerTextState extends State<AnswerText> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.isAnswerTextValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.formKey,
      onChanged: () => widget.controller.isAnswerTextValid,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CustomText.bitter600(widget.question.question ?? '', style: context.textTheme.displayMedium),
                const SizedBox(height: 28.0),
                CustomText.w400(widget.question.extraInstruction, style: context.textTheme.bodyMedium),
                const SizedBox(height: 28.0),
                SizedBox(
                  height: 200,
                  child: AnswerTextFormLimitTextField.answerText(widget.controller),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 32),
                ValueListenableBuilder<bool>(
                  valueListenable: widget.controller.isEnableSend,
                  builder: (context, isValid, _) => CustomElevatedButton.blueFullWidth(
                    onPressed: isValid ? () => widget.onNextPressed(widget.question.lessonId) : null,
                    label: LocalizedTexts.next.tr(),
                  ),
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
