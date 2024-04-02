import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/smart_goals/infrastructure/smart_goals_categories.dart';

class GoalsCategoriesList extends StatelessWidget {
  final void Function(SmartGoalsCategory value) onPressed;

  const GoalsCategoriesList({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth / 2 - 5;

        return Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: SmartGoalsCategory.values
              .map(
                (e) => SizedBox(
                  width: width,
                  child: CustomChoiceChip.emoji(
                    label: e.value,
                    avatar: e.icon,
                    selected: false,
                    value: e,
                    onSelected: onPressed,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
