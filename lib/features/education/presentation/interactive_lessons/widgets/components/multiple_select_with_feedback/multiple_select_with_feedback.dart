import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/select_feedback.dart/select_feedback.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/content_select_answer.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/select_content.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';

import '../../../../../../../localization/service/localized_texts.dart';

class MultipleSelectWithFeedback extends StatefulWidget {
  const MultipleSelectWithFeedback(
      {super.key,
      required this.onSaveProgress,
      required this.component,
      required this.lessonStreamType});

  final InteractiveLessonChunkComponentMultipleSelectWithFeedback component;
  final RiverModuleStreamType lessonStreamType;
  final Function(InteractiveLessonComponentProgress progress,
      InteractiveLessonChunkComponent component) onSaveProgress;

  @override
  State<MultipleSelectWithFeedback> createState() =>
      _MultipleSelectWithFeedbackState();
}

class _MultipleSelectWithFeedbackState
    extends State<MultipleSelectWithFeedback> {
  final List<ContentSelectAnswer> _selectedAnswers = [];
  bool isButtonDisabled = true;
  final List<ContentSelectAnswer> _answerForFeedback = [];

  @override
  void initState() {
    if (widget.component.progress == null) {
      return;
    }
    final history = widget.component.progress!.optionIds!;
    final answers = widget.component.content.answers;
    answers.map((o) {
      for (int i = 0; i < history.length; i++) {
        if (o.id == history[i]) {
          _selectedAnswers.add(o);
          _answerForFeedback.add(o);
        }
      }
    }).toList();
    super.initState();
  }

  void _onSelected(ContentSelectAnswer value) {
    if (_selectedAnswers.contains(value) && _selectedAnswers.length == 1) {
      return;
    }

    setState(() {
      isButtonDisabled = false;
      _selectedAnswers.contains(value)
          ? _selectedAnswers.remove(value)
          : _selectedAnswers.add(value);

      _answerForFeedback.contains(value)
          ? _answerForFeedback.remove(value)
          : _answerForFeedback.add(value);
    });
  }

  void _onCheckOrderHandler() {
    final order = _selectedAnswers.map((o) => o.id).toList();

    widget.onSaveProgress(
        InteractiveLessonComponentProgress(
            optionIds: order, type: widget.component.type.name),
        widget.component);

    setState(() {
      isButtonDisabled = true;
    });
  }

  SelectContent get content => widget.component.content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryLabel.interactiveLesson(
          label: LocalizedTexts.interactiveLessonsMultipleSelectLabel.tr(),
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
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: content.answers.length,
          itemBuilder: (context, index) {
            final answer = content.answers[index];
            final isSelected = _selectedAnswers.contains(answer);

            return CustomChoiceChip.blue(
              label: answer.label,
              selected: isSelected,
              value: answer,
              isCorrect: answer.isCorrect,
              onSelected: _onSelected,
            );
          },
        ),
        _answerForFeedback.isNotEmpty
            ? SelectFeedback(
                content: content, selectedAnswers: _answerForFeedback)
            : const SizedBox.shrink(),
        const SizedBox(height: 15),
        CustomElevatedButton.blueFullWidth(
          onPressed: isButtonDisabled ? null : _onCheckOrderHandler,
          label: LocalizedTexts.interactiveLessonsMultipleChoiceBtnLabel.tr(),
        ),
      ],
    );
  }
}
