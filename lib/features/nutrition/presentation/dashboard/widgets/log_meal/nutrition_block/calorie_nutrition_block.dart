import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/nutrition_block/calorie_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/nutrition_block/protein_block.dart';

class CalorieNutritionBlock extends StatelessWidget {
  final double? calorieDensity;
  final double? proteinDegree;

  const CalorieNutritionBlock({
    Key? key,
    this.calorieDensity,
    this.proteinDegree,
  }) : super(key: key);

  void _onPressHandler({required context, required int tabIndex}) {
    context.router.push(NutritionInstructionsRoute(tabIndex: tabIndex));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
            builder: (BuildContext context, state) {
              return state.maybeMap(
                nutritionInstructions: (state) => CalorieBlock(
                  value: calorieDensity,
                  onPress: ({required int tabIndex}) =>
                      _onPressHandler(context: context, tabIndex: tabIndex),
                ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          const SizedBox(height: 34.0),
          ProteinBlock(
            value: proteinDegree,
            onPress: ({required int tabIndex}) =>
                _onPressHandler(context: context, tabIndex: tabIndex),
          ),
        ],
      ),
    );
  }
}
