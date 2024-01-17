import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/calorie_density_block/calorie_density_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/protein_degree_block/protein_degree_block.dart';

class NutritionBlock extends StatelessWidget {
  final double? calorieDensity;
  final double? proteinDegree;
  final bool bottomBorder;
  final bool showArrow;

  const NutritionBlock({
    super.key,
    this.calorieDensity,
    this.proteinDegree,
    this.bottomBorder = true,
    this.showArrow = true,
  });

  void _onPressHandler({required BuildContext context, required int tabIndex}) {
    context.router.push(
      NutritionInstructionsRoute(
        tabIndex: tabIndex,
        calorieDensity: calorieDensity,
        proteinDegree: proteinDegree,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
        color: AppColors.greenLighter,
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
            Expanded(
              child: ProteinDegreeBlock(
                showArrow: showArrow,
                value: proteinDegree,
                onPress: ({required int tabIndex}) => _onPressHandler(
                  tabIndex: tabIndex,
                  context: context,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.error_outline,
                color: AppColors.blueDarker,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
