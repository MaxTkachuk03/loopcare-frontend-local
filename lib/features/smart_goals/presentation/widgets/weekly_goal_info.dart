import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';

class WeeklyGoalInfo extends StatelessWidget {
  final WeeklySmartGoal weeklyGoal;

  const WeeklyGoalInfo({super.key, required this.weeklyGoal});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomText.bitter600(weeklyGoal.title, style: context.textTheme.displayMedium),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 22.0,
                backgroundColor: AppColors.greenRegular,
                child: Icon(Icons.emoji_objects_rounded),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: CustomText.w400(
                  weeklyGoal.smartGoal.funFact,
                  style: context.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 30.0),
          child: CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.done.tr().capitalize(),
            onPressed: () => context.router.pop.call(),
          ),
        ),
      ],
    );
  }
}
