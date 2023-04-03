import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/calorie_density_block/calorie_density_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/empty_calorie_density_block/empty_calorie_density_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/empty_protein_degree_block/empty_protein_degree_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/protein_degree_block/protein_degree_block.dart';

class NutritionBlock extends StatelessWidget {
  const NutritionBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: AppColors.yellowLight))),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: BlocBuilder<NutritionInstructionsBloc,
                  NutritionInstructionsState>(
                builder: (BuildContext context, state) {
                  return state.maybeMap(
                    disabled: (_) => const EmptyCalorieDensityBlock(),
                    nutritionInstructions: (_) => const CalorieDensityBlock(),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ),
            const VerticalDivider(
              color: AppColors.yellowLight,
              width: 1.0,
              thickness: 1.0,
            ),
            Expanded(
              child: BlocBuilder<NutritionInstructionsBloc,
                  NutritionInstructionsState>(
                builder: (BuildContext context, state) {
                  return state.maybeMap(
                    disabled: (_) => const EmptyProteinDegreeBlock(),
                    nutritionInstructions: (_) => const ProteinDegreeBlock(),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
