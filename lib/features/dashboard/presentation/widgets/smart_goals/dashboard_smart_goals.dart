import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_goal_list.dart';

class DashboardSmartGoals extends StatelessWidget {
  const DashboardSmartGoals({super.key});

  void onPressHandler() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 24.0, right: 16.0, left: 16.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onPressHandler,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AppIcons.customDashboardSmartGoals,
                    const SizedBox(width: 24.0),
                    CustomText.bitter600(
                      LocalizedTexts.myGoals.tr(),
                      style: context.textTheme.headlineSmall,
                    ),
                  ],
                ),
                const ImageIcon(AppIcons.arrow, color: AppColors.blueDarker),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          const Divider(color: AppColors.blueOffRegular),
          const WeeklyGoalsList(),
        ],
      ),
    );
  }
}
