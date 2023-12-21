import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/logged_list.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/nutrition_block/calorie_nutrition_block.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/core/name_label.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

class LogMeal extends StatelessWidget {
  const LogMeal({super.key});

  void onPressHandler(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: BlocBuilder<MealsBloc, MealsState>(
        builder: (BuildContext context, mealsState) {
          return mealsState.maybeMap(
            error: (errorState) {
              final error = errorState.fetchError;

              return Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: ErrorScreen(
                  smallVersion: true,
                  error: error,
                  onButtonPressed: () => context.read<MealsBloc>().add(const MealsEvent.fetchMeals()),
                ),
              );
            },
            orElse: () {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Image(image: AppIcons.dashboardLogMeals),
                          const SizedBox(width: 24.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocalizedTexts.logYourMeals.translation,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontFamily: ThemeConstants.bitterFontFamily,
                                      color: mealsState.isEnableOnDashboard
                                          ? AppColors.darkGreen
                                          : AppColors.greyLabel,
                                    ),
                              ),
                              if (mealsState.filledCategories.isEmpty)
                                Text(
                                  mealsState.isEnableOnDashboard
                                      ? LocalizedTexts.noMealsLoggedYet.translation
                                      : LocalizedTexts.noMealsLogged.translation,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: mealsState.isEnableOnDashboard
                                            ? AppColors.darkGreen
                                            : AppColors.greyLabel,
                                      ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      mealsState.isEnableOnDashboard
                          ? Hexagon(
                              width: 42,
                              height: 42,
                              borderRadius: 16,
                              innerWidget: Container(
                                color: AppColors.bgGreen,
                                child: IconButton(
                                  icon: ImageIcon(
                                    mealsState.filledCategories.isNotEmpty ? AppIcons.edit : AppIcons.plus,
                                    color: AppColors.darkGreen,
                                    size: 12,
                                  ),
                                  onPressed: () => onPressHandler(context),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  mealsState.filledCategories.isNotEmpty
                      ? Column(
                          children: [
                            const SizedBox(height: 8.0),
                            const Divider(color: AppColors.yellowLight),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => _onIntakePressed(context),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              LocalizedTexts.logged.translation.toUpperCase(),
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    fontSize: ThemeConstants.fontSize12,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.greyLabel,
                                                  ),
                                            ),
                                            const SizedBox(
                                              width: 4.0,
                                            ),
                                            const ImageIcon(
                                              AppIcons.arrow,
                                              color: AppColors.greyLabel,
                                              size: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      LoggedList(
                                        categoryList: MealCategory.values
                                            .map((e) => e.shortLabel?.capitalizeOnlyFirstLetter() ?? '')
                                            .toList(),
                                        categoryListRaw:
                                            MealCategory.values.map((e) => e.label ?? '').toList(),
                                        filledList: mealsState.filledCategories,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 40),
                                CalorieNutritionBlock(
                                  proteinDegree: mealsState.selectedDayMealProteinDegreeSum,
                                  calorieDensity: mealsState.selectedDayMealCalorieDensitySum,
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  _onIntakePressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.dailyIntake);
  }
}
