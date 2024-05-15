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
          orElse: () => CustomScaffold.greenLightest(
            appBar: CustomAppBar.green(leading: CustomFilledIconButton.leadingGreenLighter()),
          ),
          mealsInfo: (mealsState) {
            return CustomScaffold.greenLightest(
              appBar: CustomAppBar.green(
                leading: CustomFilledIconButton.leadingGreenLighter(),
                title: state.data.currentDateTime.fullDate,
                subtitle: LocalizedTexts.loggedMeals.tr().capitalizeOnlyFirstLetter(),
              ),
              body: CustomSafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: MealCategory.values.length,
                        itemBuilder: (context, index) {
                          final selectedDayMeals =
                              mealsState.data.meals[mealsState.data.currentDateTime.isoStringWithoutTime];
                          var category = MealCategory.values[index].name;

                          var mealForCurrentCategory = selectedDayMeals?.firstWhereOrNull(
                              (m) => m.mealCategory.toLowerCase() == MealCategory.values[index].label);

                          final mealItems = mealForCurrentCategory?.mealItems;
                          final isEnabled = mealItems != null && mealItems.isNotEmpty;
                          return MealCard(
                            mealId: mealForCurrentCategory?.id,
                            title: category,
                            mealItems: isEnabled ? mealItems : null,
                            calorieDensity: isEnabled ? mealsState.data.calorieDensitySum(mealItems) : null,
                          );
                        },
                        separatorBuilder: (_, __) =>
                            const Divider(color: AppColors.blueLighter, thickness: 1.0, height: 1.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: NutritionSummary(
                        proteinDegree: mealsState.data.selectedDayMealProteinDegreeSum,
                        calorieDensity: mealsState.data.selectedDayMealCalorieDensitySum,
                        fiber: mealsState.data.selectedDayMealFiber,
                        carbFiberRatio: mealsState.data.selectedDayMealCarbFiberRatio,
                        carbsPercent: mealsState.data.carbsPercent,
                        totalCalories: mealsState.data.totalCalories,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
