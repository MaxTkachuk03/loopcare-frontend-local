import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/assignments_question_chip.dart';

class AnswerOptionsBlock extends StatelessWidget {
  final dynamic question;
  final void Function(dynamic value) onSelected;
  final List<int> selectedValues;

  const AnswerOptionsBlock({
    super.key,
    required this.question,
    required this.onSelected,
    required this.selectedValues,
  });

  void _onSelectedHandler(String label) {
    onSelected(question.lessonQuestionOptions.firstWhere((element) => element.label == label));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.bitter600(question.question ?? '', style: context.textTheme.displayMedium),
        const SizedBox(height: 28.0),
        CustomText.w400(question.extraInstruction, style: context.textTheme.bodyMedium),
        const SizedBox(height: 28.0),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: question.lessonQuestionOptions.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
          itemBuilder: (BuildContext context, int i) {
            final el = question.lessonQuestionOptions[i];

            return AssignmentsQuestionChip(
              quiz: false,
              label: el.label,
              selected: selectedValues.contains(el.id),
              onSelected: _onSelectedHandler,
            );
          },
        ),
      ],
    );
  }
}
