import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/widgets/dashboard_weekly_goals.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class DashboardSmartGoals extends StatefulWidget {
  final bool showSmartGoalsCard;
  const DashboardSmartGoals({super.key, required this.showSmartGoalsCard});

  @override
  State<DashboardSmartGoals> createState() => _DashboardSmartGoalsState();
}

class _DashboardSmartGoalsState extends State<DashboardSmartGoals> {
  bool onClick = false;

  void toggleOnClick() {
    setState(() {
      onClick = !onClick;
    });
  }

  void onPressHandler(BuildContext context) =>
      context.router.pushNamed(AppRoutes.selectGoalsCategory);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SmartGoalsBloc, SmartGoalsState>(
            builder: (context, state) {
              return DashboardCardTitle(
                onTap: () {
                  if (widget.showSmartGoalsCard) {
                    onPressHandler(context);
                  } else {
                    toggleOnClick();
                  }
                },
                highlightColor:
                    widget.showSmartGoalsCard ? AppColors.greenLightest : AppColors.white,
                leadingIcon: widget.showSmartGoalsCard
                    ? AppIcons.customDashboardSmartGoals
                    : AppIcons.customDashboardSmartGoalsGrey,
                // for the limits change we can update for add goals
                editable: state.data.weeklyGoalsSessions.length < 2,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.showSmartGoalsCard
                        ? CustomText.bitter600(
                            LocalizedTexts.smartGoalsMyGoals.tr(),
                            style: context.textTheme.headlineSmall,
                          )
                        : CustomText.bitter400(
                            LocalizedTexts.smartGoalsMyGoals.tr(),
                            style: const TextStyle(color: AppColors.greyLight, fontSize: 20),
                          ),
                  ],
                ),
                circleButton: widget.showSmartGoalsCard ? true : false,
                actionIcon: widget.showSmartGoalsCard
                    ? AppIcons.plus
                    : onClick
                        ? const AssetImage(AppIcons.upArrow)
                        : AppIcons.downArrow,
              );
            },
          ),
          widget.showSmartGoalsCard
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      AppIcons.lockGoals,
                      const SizedBox(
                        width: 36,
                      ),
                      SizedBox(
                        width: 250,
                        child: CustomText.w400(
                          "${LocalizedTexts.featureUnlocksAtPool.tr()} #${LocalizedTexts.goals.tr()}",
                          style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
          onClick
              ? Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 350,
                        child: CustomText.w400(
                          maxLines: 10,
                          LocalizedTexts.myGoalsLockedDescription.tr(),
                          style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          const DashboardWeeklyGoals(),
        ],
      ),
    );
  }
}
