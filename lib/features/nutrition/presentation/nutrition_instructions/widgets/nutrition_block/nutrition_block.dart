import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/calorie_density_block/calorie_density_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/protein_degree_block/protein_degree_block.dart';

class NutritionBlock extends StatelessWidget {
  final double? calorieDensity;
  final double? proteinDegree;

  const NutritionBlock({
    Key? key,
    this.calorieDensity,
    this.proteinDegree,
  }) : super(key: key);

  void _onPressHandler({required BuildContext context, required int tabIndex}) {
    context.router.push(NutritionInstructionsRoute(
        tabIndex: tabIndex,
        calorieDensity: calorieDensity,
        proteinDegree: proteinDegree));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        border:
            Border(bottom: BorderSide(width: 1, color: AppColors.yellowLight)),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CalorieDensityBlock(
                value: calorieDensity,
                onPress: ({required int tabIndex}) => _onPressHandler(
                  tabIndex: tabIndex,
                  context: context,
                ),
              ),
            ),
            const VerticalDivider(
              color: AppColors.yellowLight,
              width: 1.0,
              thickness: 1.0,
            ),
            Expanded(
              child: ProteinDegreeBlock(
                value: proteinDegree,
                onPress: ({required int tabIndex}) => _onPressHandler(
                  tabIndex: tabIndex,
                  context: context,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
