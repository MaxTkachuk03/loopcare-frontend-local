import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/widgets/goal_progress_button.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/goal_achieved_widget.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/goal_progress_indicator.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class GoalReviewCard extends StatelessWidget {
  final WeeklySmartGoal item;

  const GoalReviewCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CategoryLabel.smartGoals(label: item.categoryName),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: CustomText.bitter600(
            item.title,
            style: context.textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoalProgressIndicator(
              currentStep: item.completionsDays,
              steps: item.smartGoal.requiredCompletionDays,
              isAchievedNotifier: item.isAchieved,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GoalProgressButton(
                item: item,
                times: item.completionsAmount,
                onPressed: () {},
              ),
            ),
            GoalAchievedWidget(
              item: item,
            ),
          ],
        ),
        const SizedBox(
          height: 12.0,
        ),
        CustomText.w400(
          LocalizedTexts.smartGoalsGoalLogDays.plural(count: item.requiredCompletions),
          style: context.textTheme.bodyMedium,
        ),
        CustomText.w400(
          LocalizedTexts.smartGoalsGoalLogged.plural(count: item.completionsDays),
          style: context.textTheme.bodyMedium,
        ),
        CustomText.w400(
          LocalizedTexts.smartGoalsGoalTotalCompletions.plural(count: item.completionsAmount),
          style: context.textTheme.bodyMedium,
        ),
        CustomText.w400(
          item.isAchieved
              ? LocalizedTexts.smartGoalsGoalCompleted.tr()
              : LocalizedTexts.smartGoalsGoalNotCompleted.tr(),
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(height: 30.0),
      ],
    );
  }
}
