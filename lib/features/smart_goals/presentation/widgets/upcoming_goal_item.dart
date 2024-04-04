import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';

class UpcomingGoalItem extends StatelessWidget {
  final SmartGoal item;

  const UpcomingGoalItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18.0),
          CustomText.w600(
            item.title,
            style: context.textTheme.bodyLarge,
          ),
          const SizedBox(height: 10.0),
          CustomText.w400(
            'Complete 7 times in 7 days',
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 18.0),
        ],
      ),
    );
  }
}
