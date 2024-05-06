import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_summary/nutrition_summary.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/daily_intake/widgets/meal_card.dart';

class DailyIntakePage extends StatelessWidget {
  const DailyIntakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, state) {
        return state.maybeMap(
          mealsInfo: (mealsState) {
            return CustomScaffold.greenLightest(
              appBar: CustomAppBar.green(
                leading: CustomFilledIconButton.leadingGreenLighter(),
                title: state.getCurrentDate.fullDate,
                subtitle: state.isPlanningMeals
                    ? LocalizedTexts.plannedMeals.tr().capitalizeOnlyFirstLetter()
                    : LocalizedTexts.loggedMeals.tr().capitalizeOnlyFirstLetter(),
              ),
              body: CustomSafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: MealCategory.values.length,
                        itemBuilder: (context, index) {
                          final selectedDayMeals =
                              mealsState.meals[mealsState.currentDate?.isoStringWithoutTime];

                          var category = MealCategory.values[index].name;
                          var mealForCurrentCategory = selectedDayMeals?.firstWhereOrNull(
                              (element) => element.mealCategory == MealCategory.values[index].label);

                          final mealItems = mealForCurrentCategory?.mealItems;
                          final isEnabled = mealItems != null && mealItems.isNotEmpty;

                          return MealCard(
                            mealId: isEnabled ? mealForCurrentCategory?.id : null,
                            title: category,
                            mealItems: isEnabled ? mealItems : null,
                            calorieDensity: isEnabled ? mealsState.calorieDensitySum(mealItems) : null,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: AppColors.blueLighter,
                            thickness: 1.0,
                            height: 1.0,
                          );
                        },
                      ),
                    ),
                    NutritionSummary(
                      proteinDegree: mealsState.selectedDayMealProteinDegreeSum,
                      calorieDensity: mealsState.selectedDayMealProteinDegreeSum,
                      fiber: mealsState.selectedDayMealFiber,
                      carbFiberRatio: mealsState.selectedDayMealCarbFiberRatio,
                      carbsPercent: mealsState.carbsPercent,
                      totalCalories: mealsState.totalCalories,
                    ),
                  ],
                ),
              ),
            );
          },
          orElse: () => CustomScaffold.greenLightest(
            appBar: CustomAppBar.green(
              leading: CustomFilledIconButton.leadingGreenLighter(),
            ),
          ),
        );
      },
    );
  }
}
