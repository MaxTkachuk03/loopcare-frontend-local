import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/calorie_tracker/calories_tracker.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_summary/nutrition_scale.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';

class NutritionSummary extends StatelessWidget {
  final double? calorieDensity;
  final double? proteinDegree;
  final double? fiber;
  final double? carbFiberRatio;
  final double? carbsPercent;
  final double? totalCalories;
  final bool showCaloriesTracker;

  const NutritionSummary({
    super.key,
    this.calorieDensity,
    this.proteinDegree,
    this.fiber,
    this.carbFiberRatio,
    this.carbsPercent,
    this.totalCalories,
    this.showCaloriesTracker = true,
  });

  bool get _isFiberInsignificant => (carbsPercent ?? 0) < 20;

  int _getAmountOfUnlockedBlocks(BuildContext context) {
    final state = context.read<AuthenticationBloc>().state.data;
    final unlockedFoodLoggingSubFeatures = [
      state.isCalorieDensityUnlocked,
      state.isProteinDegreeUnlocked,
      state.isCarbohydrateRatioUnlocked
    ];

    return unlockedFoodLoggingSubFeatures.where((e) => e).length;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final bool useStartLayout = _getAmountOfUnlockedBlocks(context) < 3;
        final int flexVal = useStartLayout ? 0 : 1;

        return MainContainer(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: useStartLayout ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                children: [
                  if (state.data.isCalorieDensityUnlocked)
                    Expanded(
                      flex: flexVal,
                      child: NutritionScale.calorieDensity(value: calorieDensity),
                    ),
                  if (state.data.isProteinDegreeUnlocked)
                    Expanded(
                      flex: flexVal,
                      child: NutritionScale.proteinDegree(value: proteinDegree),
                    ),
                  if (state.data.isCarbohydrateRatioUnlocked)
                    Expanded(
                      flex: flexVal,
                      child: NutritionScale.fiber(
                        value: fiber,
                        totalCarbs: context.read<MealsBloc>().state.data.selectedDayMealTotalCarbs,
                        carbsFiberRatio: carbFiberRatio,
                        isFiberInsignificant: _isFiberInsignificant,
                      ),
                    ),
                ],
              ),
              if (showCaloriesTracker && state.data.isCalorieTrackerUnlocked) const SizedBox(height: 24),
              if (showCaloriesTracker && state.data.isCalorieTrackerUnlocked)
                CaloriesTracker(totalCalories: totalCalories ?? 0),
            ],
          ),
        );
      },
    );
  }
}
