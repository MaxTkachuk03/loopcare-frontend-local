import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection_question.dart';
import 'package:loopcare_frontend/features/reflections/presentation/widgets/reflection_question_options_list.dart';

class MultiChoiceQuestion extends StatefulWidget {
  final ReflectionQuestion question;
  final Function(List<int> values) onNextPressed;

  const MultiChoiceQuestion({super.key, required this.question, required this.onNextPressed});

  @override
  State<MultiChoiceQuestion> createState() => _MultiChoiceQuestionState();
}

class _MultiChoiceQuestionState extends State<MultiChoiceQuestion> {
  List<int> _selectedValuesIds = [];

  @override
  void initState() {
    super.initState();

    _selectedValuesIds = widget.question.answers.map((answer) => answer.optionId ?? 0).toList();
  }

  void _onItemPressedHandler(int value) {
    setState(() {
      _selectedValuesIds.contains(value)
          ? _selectedValuesIds.remove(value)
          : _selectedValuesIds.add(value);

      _selectedValuesIds = _selectedValuesIds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              ReflectionQuestionOptionsList(
                options: widget.question.options,
                selectedValues: _selectedValuesIds,
                onItemPressed: _onItemPressedHandler,
              ),
            ],
          ),
          BlocBuilder<ReflectionsBloc, ReflectionsState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: CustomElevatedButton.blueFullWidth(
                  onPressed: _selectedValuesIds.isNotEmpty
                      ? () => widget.onNextPressed(_selectedValuesIds)
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
