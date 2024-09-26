import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/content_select_answer.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/select_content.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SingleSelect extends StatefulWidget {
  const SingleSelect({super.key, required this.component});

  final InteractiveLessonChunkComponentSingleSelect component;

  @override
  State<SingleSelect> createState() => _SingleSelectState();
}

class _SingleSelectState extends State<SingleSelect> {
  ContentSelectAnswer? _selectedAnswer;

  void _onSelected(ContentSelectAnswer value) {
    setState(() {
      _selectedAnswer = _selectedAnswer == value ? null : value;
    });
  }

  SelectContent get content => widget.component.content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryLabel.interactiveLesson(
          label: LocalizedTexts.interactiveLessonsSingleSelectLabel.tr(),
        ),
        const SizedBox(height: 20),
        CustomText(
          content.question,
          style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: content.answers.length,
          itemBuilder: (context, index) {
            final answer = content.answers[index];
            final isSelected = _selectedAnswer == answer;

            return CustomChoiceChip.green(
              label: answer.label,
              selected: isSelected,
              value: answer,
              onSelected: _onSelected,
            );
          },
        ),
      ],
    );
  }
}
