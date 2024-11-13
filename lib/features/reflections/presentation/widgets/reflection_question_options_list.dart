import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection_question_option.dart';
import 'package:loopcare_frontend/features/reflections/presentation/widgets/reflection_question_options_list_item.dart';

class ReflectionQuestionOptionsList extends StatelessWidget {
  final List<ReflectionQuestionOption> options;
  final List<int> selectedValues;
  final Function(int value) onItemPressed;

  const ReflectionQuestionOptionsList({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: options.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int i) {
        final item = options[i];

        return ReflectionQuestionOptionsListItem(
          item: item,
          selected: selectedValues.contains(item.id),
          onSelected: onItemPressed,
        );
      },
    );
  }
}
