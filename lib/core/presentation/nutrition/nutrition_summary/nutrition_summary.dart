import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/calorie_tracker/calories_tracker.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_summary/nutrition_scale.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

class NutritionSummary extends StatelessWidget {
  final double? calorieDensity;
  final double? proteinDegree;
  final double? fiber;
  final double? carbFiberRatio;
  final double? carbsPercent;
  final double? totalCalories;
  final double? totalCarbs;
  final bool showCaloriesTracker;

  const NutritionSummary({
    super.key,
    this.calorieDensity,
    this.proteinDegree,
    this.fiber,
    this.carbFiberRatio,
    this.carbsPercent,
    this.totalCarbs,
    this.totalCalories,
    this.showCaloriesTracker = true,
  });

  bool get _isFiberInsignificant => (carbsPercent ?? 0) < 20;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return MainContainer(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  state.data.isCalorieDensityUnlocked
                      ? Expanded(child: NutritionScale.calorieDensity(value: calorieDensity))
                      : const Spacer(),
                  const SizedBox(width: 6),
                  state.data.isProteinDegreeUnlocked
                      ? Expanded(child: NutritionScale.proteinDegree(value: proteinDegree))
                      : const Spacer(),
                  const SizedBox(width: 6),
                  state.data.isCarbohydrateRatioUnlocked
                      ? Expanded(
                          child: NutritionScale.fiber(
                            value: fiber,
                            totalCarbs: totalCarbs,
                            carbsFiberRatio: carbFiberRatio,
                            isFiberInsignificant: _isFiberInsignificant,
                          ),
                        )
                      : const Spacer(),
                ],
              ),
              if (showCaloriesTracker && state.data.isCalorieTrackerUnlocked) ...[
                const SizedBox(height: 24),
                CaloriesTracker(totalCalories: totalCalories ?? 0)
              ],
            ],
          ),
        );
      },
    );
  }
}
