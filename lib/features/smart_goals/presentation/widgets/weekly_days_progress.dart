import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/application/goal_progress_controller.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/day_smart_goal_chips.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_add_completion.dart';
import 'package:provider/provider.dart';

class WeeklyDaysProgress extends StatefulWidget {
  final WeeklySmartGoal weeklyGoal;

  const WeeklyDaysProgress({super.key, required this.weeklyGoal});

  @override
  State<WeeklyDaysProgress> createState() => _WeeklyDaysProgressState();
}

class _WeeklyDaysProgressState extends State<WeeklyDaysProgress> {
  late GoalProgressController controller;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<SmartGoalsBloc>();
    bloc.add(SmartGoalsEvent.resetLoggerTimes(weeklyGoal: widget.weeklyGoal));
    controller = GoalProgressController(
      bloc: bloc,
      weeklyGoal: widget.weeklyGoal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText.w400(
              LocalizedTexts.weeklyDate.tr(),
              textAlign: TextAlign.start,
              style: context.textTheme.bodySmall,
            ),
            CustomText.w400(
              LocalizedTexts.weeklyCompletedFar.tr(),
              textAlign: TextAlign.start,
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 16),
        DaySmartGoalChips(controller: controller),
        const SizedBox(height: 28),
        WeeklyAddCompletion(controller: controller),
        const SizedBox(height: 28),
        // _CorrectionDetailsLinks(),
        // const SizedBox(height: 28),
      ],
    );
  }
}

class _CorrectionDetailsLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () {},
                text: LocalizedTexts.weeklyMakeCorrections.tr(),
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: ThemeConstants.fontSize14,
                  fontFamily: ThemeConstants.openSansFontFamily,
                  color: AppColors.blueDarkest,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.blueDarkest,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () {},
                text: LocalizedTexts.weeklyShowGoalDetails.tr(),
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: ThemeConstants.fontSize14,
                  fontFamily: ThemeConstants.openSansFontFamily,
                  color: AppColors.blueDarkest,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.blueDarkest,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
