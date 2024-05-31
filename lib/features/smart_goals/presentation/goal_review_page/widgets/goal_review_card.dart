import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/widgets/goal_progress_button.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/goal_achieved_widget.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/goal_progress_indicator.dart';

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
          child: CustomText.bitter600(item.title, style: context.textTheme.displayMedium),
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
                onPressed: () {},
              ),
            ),
            GoalProgressWidget(
              item: item,
            ),
          ],
        ),
        const SizedBox(
          height: 12.0,
        ),
        CustomText.w400(
          LocalizedTexts.goalLogDays.tr(args: [item.requiredCompletions.toString()]),
          style: context.textTheme.bodyMedium,
        ),
        CustomText.w400(
          LocalizedTexts.goalLogged.tr(args: [item.completionsDays.toString()]),
          style: context.textTheme.bodyMedium,
        ),
        CustomText.w400(
          LocalizedTexts.goalTotalCompletions.tr(args: [item.completionsAmount.toString()]),
          style: context.textTheme.bodyMedium,
        ),
        CustomText.w400(
          item.isAchieved ? LocalizedTexts.goalCompleted.tr() : LocalizedTexts.goalNotCompleted.tr(),
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 29.0,
        ),
      ],
    );
  }
}
