import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
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

class MultipleSelect extends StatefulWidget {
  const MultipleSelect(
      {super.key,
      required this.component,
      required this.onSaveProgress,
      required this.lessonStreamType});

  final InteractiveLessonChunkComponentMultipleSelect component;
  final RiverModuleStreamType lessonStreamType;
  final Function(InteractiveLessonComponentProgress progress,
      InteractiveLessonChunkComponent component) onSaveProgress;

  @override
  State<MultipleSelect> createState() => _MultipleSelectState();
}

class _MultipleSelectState extends State<MultipleSelect> {
  final List<ContentSelectAnswer> _selectedAnswers = [];
  bool isSaved = false;

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
        }
      }
    }).toList();
    isSaved = true;
    super.initState();
  }

  void _onSelected(ContentSelectAnswer value) {
    if (_selectedAnswers.contains(value) && _selectedAnswers.length == 1) {
      return;
    }

    setState(() {
      isSaved = false;
      _selectedAnswers.contains(value)
          ? _selectedAnswers.remove(value)
          : _selectedAnswers.add(value);
    });
  }

  void _onCheckOrderHandler() {
    final order = _onGetOrder();

    setState(() {
      isSaved = true;
    });

    widget.onSaveProgress(
        InteractiveLessonComponentProgress(optionIds: order), widget.component);
  }

  List<int> _onGetOrder() {
    return _selectedAnswers.map((o) => o.id).toList();
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
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: content.answers.length,
          itemBuilder: (context, index) {
            final answer = content.answers[index];
            final isSelected = _selectedAnswers.contains(answer);

            return CustomChoiceChip.green(
              label: answer.label,
              selected: isSelected,
              value: answer,
              onSelected: _onSelected,
            );
          },
        ),
        const SizedBox(
          height: 15,
        ),
        CustomElevatedButton.blueFullWidth(
          onPressed: isSaved ? null : _onCheckOrderHandler,
          label: LocalizedTexts.interactiveLessonsMultipleChoiceBtnLabel.tr(),
        ),
      ],
    );
  }
}
