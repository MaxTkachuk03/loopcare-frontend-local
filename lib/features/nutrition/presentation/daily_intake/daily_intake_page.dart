import 'package:auto_route/annotations.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_summary/nutrition_summary.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/daily_intake/widgets/meal_card.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class DailyIntakePage extends StatelessWidget {
  const DailyIntakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, state) {
        return CustomScaffold.greenLighter(
          appBar: CustomAppBar.green(
            leading: CustomFilledIconButton.leadingGreenLighter(),
            title: state.data.currentDateTime.fullDate,
            subtitle: LocalizedTexts.mealLog.tr().capitalizeEachWordFirstLetter(),
          ),
          body: state.maybeMap(
            orElse: () => const SizedBox.shrink(),
            mealsInfo: (mealsState) => CustomSafeArea(
              child: Column(
                children: [
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: MealCategory.values.length,
                    itemBuilder: (context, index) {
                      final selectedDayMeals = mealsState
                          .data.meals[mealsState.data.currentDateTime.isoStringWithoutTime];
                      var category = MealCategory.values[index];

                      var mealForCurrentCategory = selectedDayMeals?.firstWhereOrNull((m) =>
                          m.mealCategory.toLowerCase() == MealCategory.values[index].originalValue);

                      final mealItems = mealForCurrentCategory?.mealItems;
                      final isEnabled = mealItems != null && mealItems.isNotEmpty;
                      return MealCard(
                        mealId: mealForCurrentCategory?.id,
                        category: category,
                        isDisabled: !mealsState.data.isEditable,
                        mealItems: isEnabled ? mealItems : null,
                        calorieDensity:
                            isEnabled ? mealsState.data.calorieDensitySum(mealItems) : null,
                      );
                    },
                    separatorBuilder: (_, __) =>
                        const Divider(color: AppColors.greenLighter, thickness: 1.0, height: 1.0),
                  ),
                  const SizedBox(height: 40.0),
                  NutritionSummary(
                    proteinDegree: mealsState.data.selectedDayMealProteinDegreeSum,
                    calorieDensity: mealsState.data.selectedDayMealCalorieDensitySum,
                    fiber: mealsState.data.selectedDayMealFiber,
                    carbFiberRatio: mealsState.data.selectedDayMealCarbFiberRatio,
                    carbsPercent: mealsState.data.selectedDayMealCarbsPercent,
                    totalCalories: mealsState.data.selectedDayMealTotalCaloriesWithDrinks,
                    totalCarbs: mealsState.data.selectedDayMealTotalCarbs,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
