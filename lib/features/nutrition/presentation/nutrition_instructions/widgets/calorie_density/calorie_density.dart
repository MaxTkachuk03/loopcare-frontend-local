import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_layout.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/instructions_block/instructions_block.dart';

class CalorieDensity extends StatelessWidget {
  final double? value;

  const CalorieDensity({
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 26,
                  height: 140,
                  child: BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
                    builder: (BuildContext context, state) {
                      return state.maybeMap(
                        loaded: (state) {
                          return CalorieDensityScale(
                            density: value,
                            separatorColor: AppColors.white,
                            layout: CalorieDensityScaleLayout.vertical,
                          );
                        },
                        orElse: () => const SizedBox.shrink(),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 24.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
                        builder: (BuildContext context, state) {
                          return state.maybeMap(
                            loaded: (state) {
                              final valueLabel = value == null ? '-' : '${value?.toStringAsFixed(2)}';

                              return Text(
                                '${LocalizedTexts.calorieDensity.translation}: $valueLabel',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              );
                            },
                            orElse: () => const SizedBox.shrink(),
                          );
                        },
                      ),
                      const SizedBox(height: 8.0),
                      BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
                        builder: (BuildContext context, state) {
                          return state.maybeMap(
                            loaded: (state) {
                              final currentCalorieDensityItem = state.data.getCalorieDensityItem(value);

                              if (state.data.calorieDensityValues.isEmpty ||
                                  currentCalorieDensityItem == null) {
                                return const SizedBox();
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    currentCalorieDensityItem.label.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.blueDark,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    currentCalorieDensityItem.text,
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
                )
              ],
            ),
          ),
          const SizedBox(height: 28.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                LocalizedTexts.whatIsCalorieDensity.translation,
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
              const SizedBox(height: 52.0),
              const InstructionsBlock(),
            ],
          ),
          const SizedBox(height: 28.0),
        ],
      ),
    );
  }
}
