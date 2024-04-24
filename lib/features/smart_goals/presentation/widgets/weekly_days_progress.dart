import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/application/goal_progress_controller.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/day_smart_goal_chips.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_add_completion.dart';

class WeeklyDaysProgress extends StatelessWidget {
  final Key key;
  final WeeklySmartGoal weeklyGoal;
  final GoalProgressController controller;
  final void Function() onDone;

  const WeeklyDaysProgress({
    required this.key,
    required this.weeklyGoal,
    required this.controller,
    required this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        CustomText.w600(
          LocalizedTexts.weeklyCompleteTitle.tr(),
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText.w400(
                LocalizedTexts.weeklyDate.tr(),
                textAlign: TextAlign.start,
                style: context.textTheme.bodyMedium,
              ),
              CustomText.w400(
                LocalizedTexts.weeklyCompletedFar.tr(),
                textAlign: TextAlign.start,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: DaySmartGoalChips(controller: controller),
        ),
        WeeklyAddCompletion(controller: controller),
      ],
    );
  }
}
