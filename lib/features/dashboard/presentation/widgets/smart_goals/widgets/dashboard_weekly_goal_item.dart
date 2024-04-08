import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/custom_rounded_button_with_icon.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/goal_progress_indicator.dart';

class DashboardWeeklyGoalItem extends StatelessWidget {
  final WeeklySmartGoal item;

  const DashboardWeeklyGoalItem({super.key, required this.item});

  void onPressHandler(BuildContext context) {
    // push route
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GoalProgressIndicator(
            currentStep: item.progressLogs?.last.times ?? 0,
            steps: item.smartGoal.requiredDays,
            //Todo add logic to calculate progress
            isAchievedNotifier: (item.progressLogs?.last.times ?? 0) >= item.smartGoal.requiredCompletions,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: CustomText.w400(
              item.smartGoal.title,
              style: context.textTheme.bodySmall,
            ),
          ),
          const SizedBox(width: 16.0),
          CustomOutlinedRoundedButtonWithIcon(
            onPressed: () => onPressHandler(context),
            icon: AppIcons.checkmark,
          ),
        ],
      ),
    );
  }
}
