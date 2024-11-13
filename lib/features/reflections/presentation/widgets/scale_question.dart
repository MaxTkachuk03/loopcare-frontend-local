import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scoring_scale.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection_question.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class ScaleQuestion extends StatefulWidget {
  final ReflectionQuestion question;
  final Function(String value) onNextPressed;

  const ScaleQuestion({super.key, required this.question, required this.onNextPressed});

  @override
  State<ScaleQuestion> createState() => _ScaleQuestionState();
}

class _ScaleQuestionState extends State<ScaleQuestion> {
  int _selectedScore = -1;
  String _feedback = '';

  @override
  void initState() {
    super.initState();

    final answers = widget.question.answers;
    if (answers.isEmpty) return;

    final answerOption = answers.first.optionId;

    if (answerOption == null) return;

    _selectedScore = answerOption - 1;
    _feedback = _getFeedbackText(answerOption);
  }

  void _onSelectedHandler(int value) {
    setState(() {
      _selectedScore = value;
      _feedback = _getFeedbackText(value + 1);
    });
  }

  String _getFeedbackText(value) =>
      widget.question.feedbacks.firstWhere((f) => f.minValue <= value && value <= f.maxValue).text;

  String get _instructions => widget.question.extraInstruction ?? '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText.w400(
                widget.question.introduction ?? '',
                style: context.textTheme.bodyLarge,
              ),
              const SizedBox(height: 28.0),
              CustomText.bitter600(
                widget.question.question ?? '',
                style: context.textTheme.displayMedium,
              ),
              const SizedBox(height: 28.0),
              CustomText.bitter600(
                widget.question.extraInstruction ?? '',
                style: context.textTheme.bodyMedium,
              ),
              if (_instructions.isNotEmpty) const SizedBox(height: 28.0),
              ScoringScale(
                selectedColor: AppColors.greenRegular,
                selectedScore: _selectedScore,
                onScoreTap: _onSelectedHandler,
                scaleSize: widget.question.options.length,
                labels: widget.question.options.map((o) => o.label).toList(),
                borderColor: AppColors.blueDarker,
              ),
              const SizedBox(height: 14.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText.w600(
                    widget.question.lowestText ?? LocalizedTexts.veryEasy.tr(),
                    style: context.textTheme.bodySmall,
                  ),
                  CustomText.w600(
                    widget.question.highestText ?? LocalizedTexts.veryHard.tr(),
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
              if (_feedback.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: CustomText.w600(_feedback, style: context.textTheme.bodyLarge),
                ),
            ],
          ),
          BlocBuilder<ReflectionsBloc, ReflectionsState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: CustomElevatedButton.blueFullWidth(
                  onPressed: _selectedScore != -1
                      ? () => widget.onNextPressed((_selectedScore + 1).toString())
                      : null,
                  label: LocalizedTexts.next.tr(),
                  isLoading: state is ReflectionsStateLoading,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
