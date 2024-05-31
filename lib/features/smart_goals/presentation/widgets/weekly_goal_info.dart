import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';

class WeeklyGoalInfo extends StatelessWidget {
  final Key? key;
  final WeeklySmartGoal weeklyGoal;

  const WeeklyGoalInfo({
    this.key,
    required this.weeklyGoal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 44.0,
          width: 44,
          child: AppIcons.lightbulbUnSelect,
        ),
        const SizedBox(height: 16.0),
        CustomText.bitter600(
          weeklyGoal.title,
          style: context.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: CustomText.w400(
              weeklyGoal.smartGoal.funFact,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.ok.tr().toUpperCase(),
            onPressed: () => context.router.pop(),
          ),
        ),
      ],
    );
  }
}
