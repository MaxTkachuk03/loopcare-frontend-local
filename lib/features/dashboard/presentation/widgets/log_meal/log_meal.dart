import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_summary/nutrition_summary.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/core/name_label.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

class LogMeal extends StatelessWidget {
  const LogMeal({super.key});

  void _onPressHandler(BuildContext context) {
    ModalBottomSheet.selectAMealDialog(
      context: context,
      filledList: context.read<MealsBloc>().state.filledCategories,
      currentDate: context.read<MealsBloc>().state.getCurrentDate,
      list: MealCategory.values
          .map(
            (e) => NameLabel(
              name: e.name,
              label: e.label ?? '',
              shortValue: e.shortValue,
              icon: e.icon,
            ),
          )
          .toList(),
      onSelect: (NameLabel item) {
        final mealsBloc = context.read<MealsBloc>();
        final plannedMeals = mealsBloc.state.mapOrNull(mealsInfo: (s) => s.plannedMeals);
        final plannedMealsForCurrentDate = plannedMeals?[mealsBloc.state.getCurrentDate.isoStringWithoutTime]
            ?.firstWhereOrNull((element) => element.mealCategory == item.label);

        if (plannedMealsForCurrentDate != null) {
          context.router.push(LogPlannedMealsRoute(selectedMealCategory: item));

          return;
        }

        final mealCategory = item.name.toLowerCase();

        mealsBloc.add(MealsEvent.addMeal(mealCategory));

        context.router.push(SelectFoodRoute(mealCategory: item.name));
      },
    );
  }

  _onIntakePressed(BuildContext context) => context.router.pushNamed(AppRoutes.dailyIntake);

  // state.isEnableOnDashboard ? () => _onIntakePressed(context) : null

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: BlocBuilder<MealsBloc, MealsState>(
        builder: (context, state) {
          final Color textColor = state.isEnableOnDashboard ? AppColors.blueDarker : AppColors.greyLabel;

          return Column(
            children: [
              DashboardCardTitle(
                onTap: () => _onPressHandler(context),
                highlightColor: AppColors.greenLightest,
                leadingIcon: AppIcons.customDashboardLogMeals,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.bitter600(
                      LocalizedTexts.logYourMeals.tr(),
                      style: context.textTheme.headlineSmall?.copyWith(color: textColor),
                    ),
                    if (state.filledCategories.isEmpty)
                      CustomText.w400(
                        state.isEnableOnDashboard
                            ? LocalizedTexts.noMealsLoggedYet.tr()
                            : LocalizedTexts.noMealsLogged.tr(),
                        style: context.textTheme.bodySmall?.copyWith(color: textColor),
                      ),
                  ],
                ),
                actionIcon: AppIcons.arrow,
                circleButton: false,
                editable: state.isEnableOnDashboard,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    const Divider(color: AppColors.blueOffRegular, height: 36),
                    BlocBuilder<MealsBloc, MealsState>(builder: (context, state) {
                      return state.maybeMap(
                        loading: (_) => const Loader(),
                        error: (errorState) {
                          final error = errorState.fetchError;

                          return Container(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            child: ErrorScreen(
                              error: error,
                              onButtonPressed: () =>
                                  context.read<MealsBloc>().add(const MealsEvent.fetchMeals()),
                            ),
                          );
                        },
                        orElse: () => NutritionSummary(
                          proteinDegree: state.selectedDayMealProteinDegreeSum,
                          calorieDensity: state.selectedDayMealCalorieDensitySum,
                          fiber: state.selectedDayMealFiber,
                          carbFiberRatio: state.selectedDayMealCarbFiberRatio,
                          carbsPercent: state.selectedDayMealCarbsPercent,
                          totalCalories: state.selectedDayMealCalories,
                          showCaloriesTracker: false,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
