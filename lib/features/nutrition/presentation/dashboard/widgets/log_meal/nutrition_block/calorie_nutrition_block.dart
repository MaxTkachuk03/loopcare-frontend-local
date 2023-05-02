import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/nutrition_block/calorie_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/nutrition_block/disabled_calorie_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/nutrition_block/disabled_protein_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/nutrition_block/protein_block.dart';

class CalorieNutritionBlock extends StatelessWidget {
  const CalorieNutritionBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
            builder: (BuildContext context, state) {
              return state.maybeMap(
                disabled: (_) => const DisabledCalorieBlock(),
                nutritionInstructions: (_) => const CalorieBlock(),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          const SizedBox(height: 34.0),
          BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
            builder: (BuildContext context, state) {
              return state.maybeMap(
                disabled: (_) => const DiabledProteinBlock(),
                nutritionInstructions: (_) => const ProteinBlock(),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }
}
