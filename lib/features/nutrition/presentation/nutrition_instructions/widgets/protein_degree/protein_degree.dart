import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';

class ProteinDegree extends StatelessWidget {
  final double? value;

  const ProteinDegree({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollableContainer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30.0),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<NutritionInstructionsBloc,
                    NutritionInstructionsState>(
                  builder: (BuildContext context, state) {
                    return state.maybeMap(
                      nutritionInstructions: (state) {
                        final currentProteinDegreeItem =
                            state.getProteinDegreeItem(value);

                        if (state.proteinDegreeValues.isEmpty ||
                            currentProteinDegreeItem == null) {
                          return const SizedBox();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${LocalizedTexts.proteinDegree.translation}: ${value?.round()}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              currentProteinDegreeItem.label.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: AppColors.blueDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              currentProteinDegreeItem.text,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 28.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                LocalizedTexts.whatIsProtein.translation,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8.0),
              Text(
                LocalizedTexts.calorieDensityExplanationOne.translation,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16.0),
              Text(
                LocalizedTexts.calorieDensityExplanationTwo.translation,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
