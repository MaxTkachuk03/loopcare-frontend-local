import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/nutrition_block/calorie_block.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/nutrition_block/protein_block.dart';

class CalorieNutritionBlock extends StatelessWidget {
  final double? calorieDensity;
  final double? proteinDegree;

  const CalorieNutritionBlock({
    super.key,
    this.calorieDensity,
    this.proteinDegree,
  });

  void _onPressHandler(BuildContext context, {required int tabIndex}) {
    context.router.push(NutritionInstructionsRoute(
      tabIndex: tabIndex,
      calorieDensity: calorieDensity,
      proteinDegree: proteinDegree,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalorieBlock(
            value: calorieDensity,
            onPress: ({required int tabIndex}) => _onPressHandler(context, tabIndex: tabIndex),
          ),
          const SizedBox(height: 34.0),
          ProteinBlock(
            value: proteinDegree,
            onPress: ({required int tabIndex}) => _onPressHandler(context, tabIndex: tabIndex),
          ),
        ],
      ),
    );
  }
}
