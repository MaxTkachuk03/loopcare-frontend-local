import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_input_limit_field.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection_question.dart';
import 'package:loopcare_frontend/features/reflections/presentation/validators/text_answer_validator.dart';

class TextQuestion extends StatefulWidget {
  final ReflectionQuestion question;
  final Function(String value) onNextPressed;

  const TextQuestion({super.key, required this.question, required this.onNextPressed});

  @override
  State<TextQuestion> createState() => _TextQuestionState();
}

class _TextQuestionState extends State<TextQuestion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  bool _isValid = false;

  @override
  void initState() {
    super.initState();

    final answer = widget.question.answers.isNotEmpty ? widget.question.answers.first : null;
    if (answer == null) return;

    _controller.text = answer.text ?? '';
    _isValid = answer.text != null;
  }

  void _onInputChangeHandler(_) {
    setState(() {
      _isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText.bitter600(
                  widget.question.question ?? '',
                  style: context.textTheme.displayMedium,
                ),
                const SizedBox(height: 28.0),
                CustomText.w400(
                  widget.question.extraInstruction ?? '',
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(height: 28.0),
                SizedBox(
                  height: 200,
                  child: AppLimitTextField(
                    controller: _controller,
                    validator: textAnswerValidator,
                    textInputAction: TextInputAction.newline,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: _onInputChangeHandler,
                    enforcedLimitCount: MaxLengthEnforcement.none,
                    limitCount: 20000,
                    minLines: 30,
                    linesCount: 50,
                    focusedColor: AppColors.blueMid,
                    cursorColor: AppColors.darkGreen,
                    hintText: '',
                  ),
                ),
              ],
            ),
            BlocBuilder<ReflectionsBloc, ReflectionsState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: CustomElevatedButton.blueFullWidth(
                    onPressed: _isValid ? () => widget.onNextPressed(_controller.text) : null,
                    label: LocalizedTexts.next.tr(),
                    isLoading: state is ReflectionsStateLoading,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
