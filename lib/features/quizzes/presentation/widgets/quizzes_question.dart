import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_option.dart';
import 'package:loopcare_frontend/features/quizzes/infrastructure/questions_page_mode.dart';
import 'package:loopcare_frontend/features/quizzes/presentation/widgets/quizzes_question_chip.dart';

class QuizzesQuestion extends StatefulWidget {
  final QuestionsPageMode mode;
  final LessonQuestion question;
  final void Function(LessonQuestionOption value) onSelected;
  final LessonQuestionOption? selectedValue;

  const QuizzesQuestion({
    super.key,
    required this.mode,
    required this.question,
    required this.onSelected,
    this.selectedValue,
  });

  @override
  State<QuizzesQuestion> createState() => _QuizzesQuestionState();
}

class _QuizzesQuestionState extends State<QuizzesQuestion> {
  void _onSelectedHandler(String label) {
    widget.onSelected(widget.question.lessonQuestionOptions.firstWhere((element) => element.label == label));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.bitter600(
          widget.question.question ?? '',
          style: context.textTheme.displayMedium,
        ),
        const SizedBox(height: 28.0),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.question.lessonQuestionOptions.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final el = widget.question.lessonQuestionOptions[i];

            return widget.mode.map(
              askQuestion: (_) => QuizzesQuestionChip(
                label: el.label,
                selected: widget.selectedValue?.id == el.id,
                onSelected: _onSelectedHandler,
              ),
              showAnswer: (_) {
                var isCorrect = el.isCorrect ?? false;
                return QuizzesQuestionChip(
                  label: el.label,
                  selected: widget.selectedValue?.id == el.id,
                  onSelected: (String value) {},
                  correct: (!isCorrect && widget.selectedValue?.id == el.id) || isCorrect ? isCorrect : null,
                  active: (!isCorrect && widget.selectedValue?.id == el.id) || isCorrect ? true : false,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
