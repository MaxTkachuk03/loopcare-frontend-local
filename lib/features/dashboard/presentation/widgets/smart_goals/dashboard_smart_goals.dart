import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/river_module_item/river_module_item.dart';
import 'package:loopcare_frontend/core/presentation/river_module_item/river_module_item_utils.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/widgets/dashboard_weekly_goals.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';

class DashboardSmartGoals extends StatelessWidget {
  const DashboardSmartGoals({super.key});

  void onPressHandler(BuildContext context) => context.router.pushNamed(AppRoutes.selectGoalsCategory);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          BlocBuilder<SmartGoalsBloc, SmartGoalsState>(
            builder: (context, state) {
              return DashboardCardTitle(
                onTap: () => onPressHandler(context),
                highlightColor: AppColors.greenLightest,
                leadingIcon: AppIcons.customDashboardSmartGoals,
                editable: state.data.weeklyGoalsSessions.length < 2,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText.bitter600(
                      LocalizedTexts.myGoals.tr(),
                      style: context.textTheme.headlineSmall,
                    ),
                  ],
                ),
                actionIcon: AppIcons.plus,
              );
            },
          ),
          const DashboardWeeklyGoals(),
        ],
      ),
    );
  }
}
