import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_summary/nutrition_summary.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/pool_status/application/pool_bloc/pool_module_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class FoodLoggingDashboard extends StatefulWidget {
  final DateTime selectedDay;
  final bool locked;

  const FoodLoggingDashboard({super.key, required this.selectedDay, required this.locked});

  @override
  State<FoodLoggingDashboard> createState() => _FoodLoggingDashboardState();
}

class _FoodLoggingDashboardState extends State<FoodLoggingDashboard> {
  bool onClick = false;

  void toggleOnClick() {
    setState(() {
      onClick = !onClick;
    });
  }

  void _onPressHandler(BuildContext context) =>
      context.router.pushNamed(AppRoutes.dailyIntake).then(getPoolData);

  void getPoolData(e) => context.read<PoolModuleBloc>().add(const PoolModuleEvent.getPoolData());
  void onErrorHandler(BuildContext context) => context
      .read<MealsBloc>()
      .add(MealsEvent.fetchMeals(startDate: widget.selectedDay, endDate: widget.selectedDay));

  Color get _textColor => !widget.selectedDay.isFuture ? AppColors.blueDarker : AppColors.greyLabel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            children: [
              DashboardCardTitle(
                onTap: () {
                  if (widget.locked) {
                    _onPressHandler(context);
                  } else {
                    toggleOnClick();
                  }
                },
                highlightColor: widget.locked ? AppColors.greenLightest : AppColors.white,
                leadingIcon: widget.locked
                    ? AppIcons.customDashboardLogMeals
                    : AppIcons.customDashboardLogMealsGrey,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.locked
                        ? CustomText.bitter600(
                            LocalizedTexts.mealLog.tr(),
                            style: context.textTheme.headlineSmall?.copyWith(color: _textColor),
                          )
                        : CustomText.bitter400(
                            LocalizedTexts.mealLog.tr(),
                            style: const TextStyle(color: AppColors.greyLight, fontSize: 20),
                          ),
                  ],
                ),
                actionIcon: widget.locked
                    ? AppIcons.arrow
                    : onClick
                        ? const AssetImage(AppIcons.upArrow)
                        : AppIcons.downArrow,
                circleButton: widget.locked ? true : false,
                editable: widget.locked ? true : !widget.selectedDay.isFuture,
              ),
              widget.locked
                  ? Container()
                  : BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) => state.data.isNutritionScalesLocked
                          ? const SizedBox.shrink()
                          : const Divider(color: AppColors.blueOffRegular),
                    ),
              widget.locked
                  ? Container()
                  : state.maybeMap(
                      loading: (_) => const Loader(),
                      error: (s) {
                        final error = s.data.error;

                        return ErrorScreen(
                            error: error!, onButtonPressed: () => onErrorHandler(context));
                      },
                      orElse: () => NutritionSummary(
                        proteinDegree: state.data.selectedDayMealProteinDegreeSum,
                        calorieDensity: state.data.selectedDayMealCalorieDensitySum,
                        fiber: state.data.selectedDayMealFiber,
                        carbFiberRatio: state.data.selectedDayMealCarbFiberRatio,
                        carbsPercent: state.data.selectedDayMealCarbsPercent,
                        totalCalories: state.data.selectedDayMealTotalCaloriesWithDrinks,
                        totalCarbs: state.data.selectedDayMealTotalCarbs,
                        showCaloriesTracker: false,
                      ),
                    ),
              widget.locked
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
                              "${LocalizedTexts.featureUnlocksAtPool.tr()} ${LocalizedTexts.foodLog.tr()}",
                              style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
              onClick && !widget.locked
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 350,
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CustomText.w400(
                              maxLines: 10,
                              LocalizedTexts.foodLogLockedDescription.tr(),
                              style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
