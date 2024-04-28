import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/nutrition_summary/nutrition_scale.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';

class NutritionSummary extends StatelessWidget {
  final double? calorieDensity;
  final double? proteinDegree;
  final double? fiber;
  final double? carbFiberRatio;

  const NutritionSummary({
    super.key,
    this.calorieDensity,
    this.proteinDegree,
    this.fiber,
    this.carbFiberRatio,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          orElse: () => const SizedBox.shrink(),
          loading: (_) => const Loader(),
          loaded: (state) {
            final currentCalorieDensityItem = state.data.getCalorieDensityItem(calorieDensity);

            if (state.data.calorieDensityValues.isEmpty || currentCalorieDensityItem == null) {
              return const SizedBox();
            }

            final currentProteinDegreeItem = state.data.getProteinDegreeItem(proteinDegree);

            if (state.data.proteinDegreeValues.isEmpty || currentProteinDegreeItem == null) {
              return const SizedBox();
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: NutritionScale.calorieDensity(
                      bottomLabel: currentCalorieDensityItem.label, value: calorieDensity),
                ),
                Expanded(
                  child: NutritionScale.proteinDegree(
                      bottomLabel: currentProteinDegreeItem.label, value: proteinDegree),
                ),
                Expanded(
                  child: NutritionScale.fiber(
                    bottomLabel: currentProteinDegreeItem.label,
                    value: fiber,
                    totalCarbs: context.read<MealsBloc>().state.selectedDayMealTotalCarbs,
                    carbsFiberRatio: carbFiberRatio,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
