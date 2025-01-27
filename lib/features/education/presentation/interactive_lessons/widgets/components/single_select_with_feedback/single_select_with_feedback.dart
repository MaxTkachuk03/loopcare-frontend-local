import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/content_select_answer.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/select_content.dart';
import 'package:loopcare_frontend/core/presentation/select_feedback.dart/select_feedback.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';

class SingleSelectWithFeedback extends StatefulWidget {
  const SingleSelectWithFeedback({
    super.key,
    required this.component,
    required this.lessonStreamType,
    required this.onSaveProgress,
  });

  final InteractiveLessonChunkComponentSingleSelectWithFeedback component;
  final RiverModuleStreamType lessonStreamType;
  final Function(InteractiveLessonComponentProgress progress,
      InteractiveLessonChunkComponent component) onSaveProgress;

  @override
  State<SingleSelectWithFeedback> createState() =>
      _SingleSelectWithFeedbackState();
}

class _SingleSelectWithFeedbackState extends State<SingleSelectWithFeedback> {
  final List<int> _selectedAnswer = [];
  ContentSelectAnswer? _answerForFeedback;

  @override
  initState() {
    super.initState();
    if (widget.component.progress == null) return;
    if (widget.component.progress!.optionIds!.isNotEmpty) {
      final optionId = widget.component.progress!.optionIds!.first;
      final answer = widget.component.content.answers
          .where((answer) => answer.id == optionId)
          .first;
      _selectedAnswer.add(answer.id);
      _answerForFeedback = answer;
    }
  }

  void _onSelected(ContentSelectAnswer value) {
    if (_selectedAnswer.isNotEmpty) return;

    setState(() {
      _selectedAnswer.add(value.id);
      _answerForFeedback = value;
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
          style: context.textTheme.bodyMedium!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: content.answers.length,
          itemBuilder: (context, index) {
            final answer = content.answers[index];
            final isSelected = answer == _answerForFeedback;

            return CustomChoiceChip.blue(
              label: answer.label,
              selected: isSelected,
              value: answer,
              isCorrect: answer.isCorrect,
              onSelected: _onSelected,
            );
          },
        ),
        SelectFeedback(content: content, selectedAnswer: _answerForFeedback),
      ],
    );
  }
}
