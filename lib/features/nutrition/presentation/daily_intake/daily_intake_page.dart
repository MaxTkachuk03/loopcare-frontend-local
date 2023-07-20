import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/daily_intake/widgets/meal_card.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';

class DailyIntakePage extends StatelessWidget {
  const DailyIntakePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          mealsInfo: (mealsState) {
            return Scaffold(
              appBar: BlueAppBar(
                isCustomLeading: true,
                title: state.getCurrentDate.fullDate,
                subtitle: state.isPlanningMeals
                    ? LocalizedTexts.plannedMeals.translation.capitalizeOnlyFirstLetter()
                    : LocalizedTexts.loggedMeals.translation.capitalizeOnlyFirstLetter(),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: MealCategory.values.length,
                        itemBuilder: (BuildContext context, index) {
                          final selectedDayMeals =
                              mealsState.meals[mealsState.currentDate?.isoStringWithoutTime];

                          var category = MealCategory.values[index].name;
                          var mealForCurrentCategory = selectedDayMeals?.firstWhereOrNull(
                              (element) => element.mealCategory == MealCategory.values[index].label);

                          final mealItems = mealForCurrentCategory?.mealItems;

                          return MealCard(
                            mealId: mealForCurrentCategory?.id,
                            title: category,
                            mealItems: mealItems,
                            calorieDensity:
                                mealItems != null ? mealsState.calorieDensitySum(mealItems) : null,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            color: AppColors.yellowLight,
                            thickness: 1.0,
                            height: 1.0,
                          );
                        },
                      ),
                    ),
                    NutritionBlock(
                      proteinDegree: mealsState.selectedDayMealProteinDegreeSum,
                      calorieDensity: mealsState.selectedDayMealCalorieDensitySum,
                    ),
                  ],
                ),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
