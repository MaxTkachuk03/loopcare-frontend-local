import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/custom_rounded_button_with_icon.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/goal_progress_indicator.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_goal_modal.dart';
import 'package:provider/provider.dart';

class DashboardWeeklyGoalItem extends StatelessWidget {
  final WeeklySmartGoal item;
  final bool editable;

  const DashboardWeeklyGoalItem({super.key, required this.item, required this.editable});

  void onPressHandler(BuildContext context, WeeklySmartGoal item) {
    context.read<SmartGoalsBloc>().add(SmartGoalsEvent.resetLoggerTimes(weeklyGoal: item));
    ModalBottomSheet.smartGoalComplete(
      context: context,
      content: WeeklyGoalModal(
        weeklyGoal: item,
        onDone: () => context.read<SmartGoalsBloc>().add(
              SmartGoalsEvent.postCompletions(reviewId: item.id),
            ),
      ),
    );
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
            currentStep: item.completionsDays,
            steps: item.smartGoal.requiredCompletions,
            isAchievedNotifier: item.isAchieved,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: CustomText.w400(
              item.smartGoal.title,
              style: context.textTheme.bodySmall,
            ),
          ),
          const SizedBox(width: 16.0),
          if (editable)
            CustomOutlinedRoundedButtonWithIcon(
              onPressed: () => onPressHandler(context, item),
              icon: AppIcons.checkmark,
            ),
        ],
      ),
    );
  }
}
