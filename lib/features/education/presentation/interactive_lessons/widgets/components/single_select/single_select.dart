import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/content_select_answer.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/select_content.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';

class SingleSelect extends StatefulWidget {
  const SingleSelect({
    super.key,
    required this.component,
    required this.lessonStreamType,
    required this.onSaveProgress,
  });

  final InteractiveLessonChunkComponentSingleSelect component;
  final RiverModuleStreamType lessonStreamType;
  final Function(
          InteractiveLessonComponentProgress progress, InteractiveLessonChunkComponent component)
      onSaveProgress;

  @override
  State<SingleSelect> createState() => _SingleSelectState();
}

class _SingleSelectState extends State<SingleSelect> {
  final List<int> _selectedAnswer = [];

  @override
  initState() {
    super.initState();
    if (widget.component.progress == null) return;
    if (widget.component.progress!.optionIds!.isNotEmpty) {
      final optionId = widget.component.progress!.optionIds!.first;
      final answer =
          widget.component.content.answers.where((answer) => answer.id == optionId).first;
      _selectedAnswer.add(answer.id);
    }
  }

  void _onSelected(ContentSelectAnswer value) {
    if (_selectedAnswer.isNotEmpty) {
      return;
    }

    setState(() {
      _selectedAnswer.add(value.id);
    });

    widget.onSaveProgress(
        InteractiveLessonComponentProgress(
            optionIds: _selectedAnswer, type: widget.component.type.name),
        widget.component);
  }

  SelectContent get content => widget.component.content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryLabel.interactiveLesson(
          label: LocalizedTexts.interactiveLessonsSingleSelectLabel.tr(),
          lessonStreamType: widget.lessonStreamType,
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
            final isSelected = _selectedAnswer.contains(answer.id);

            return CustomChoiceChip.blue(
              label: answer.label,
              selected: isSelected,
              value: answer,
              onSelected: _onSelected,
              isCorrect: true,
            );
          },
        ),
      ],
    );
  }
}
