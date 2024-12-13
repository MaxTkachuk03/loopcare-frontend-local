import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz_question.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz_question_option.dart';
import 'package:loopcare_frontend/features/lesson_quiz/infrastructure/questions_page_mode.dart';
import 'package:loopcare_frontend/features/lesson_quiz/presentation/widgets/quiz_question_chip.dart';

class QuizQuestionOptionsList extends StatefulWidget {
  final QuestionsPageMode mode;
  final QuizQuestion question;
  final void Function(QuizQuestionOption value) onSelected;
  final int selectedValue;

  const QuizQuestionOptionsList({
    super.key,
    required this.mode,
    required this.question,
    required this.onSelected,
    required this.selectedValue,
  });

  @override
  State<QuizQuestionOptionsList> createState() => _QuizQuestionOptionsListState();
}

class _QuizQuestionOptionsListState extends State<QuizQuestionOptionsList> {
  void _onSelectedHandler(QuizQuestionOption value) {
    widget.onSelected(widget.question.options.firstWhere((o) => o.id == value.id));
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
          itemCount: widget.question.options.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final el = widget.question.options[i];

            return widget.mode.map(
              askQuestion: (_) => QuizQuestionChip(
                value: el,
                selected: widget.selectedValue == el.id,
                onSelected: _onSelectedHandler,
              ),
              showAnswer: (_) {
                var isCorrect = el.isCorrect ?? false;
                return QuizQuestionChip(
                  value: el,
                  selected: widget.selectedValue == el.id,
                  onSelected: (_) {},
                  correct:
                      (!isCorrect && widget.selectedValue == el.id) || isCorrect ? isCorrect : null,
                  active: (!isCorrect && widget.selectedValue == el.id) || isCorrect ? true : false,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
