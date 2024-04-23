import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/application/goal_progress_controller.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/day_smart_goal_chips.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_add_completion.dart';

class WeeklyDaysProgress extends StatelessWidget {
  final WeeklySmartGoal weeklyGoal;
  final GoalProgressController controller;
  final void Function() onDone;

  const WeeklyDaysProgress({
    super.key,
    required this.weeklyGoal,
    required this.controller,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 30),
          child: CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.done.tr().capitalize(),
            onPressed: () {
              onDone();
              context.router.pop();
            },
          ),
        ),
      ],
    );
  }
}
