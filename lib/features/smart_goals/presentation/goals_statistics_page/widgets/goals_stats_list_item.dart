import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_statistics.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/goals_statistics_page/widgets/goal_progress.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class GoalsStatsListItem extends StatelessWidget {
  final SmartGoalStatistics item;

  const GoalsStatsListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText.w400(item.category.name, style: context.textTheme.bodySmall),
            CustomText.w400(
              '${item.completed} ${LocalizedTexts.smartGoalsAccomplished.tr()}',
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        GoalProgress(value: item.completed / item.total),
      ],
    );
  }
}
