import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/custom_calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/instructions_block/instructions_block.dart';

class CalorieDensity extends StatelessWidget {
  final double? value;

  const CalorieDensity({
    super.key,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollableContainer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
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
                                children: [
                                  CustomCalorieDensityScale(
                                    density: value,
                                    label: value?.toStringAsFixed(2) ?? '',
                                  ),
                                  const SizedBox(height: 8.0),
                                  CustomText.w600(
                                    currentCalorieDensityItem.label.capitalize(),
                                    style: context.textTheme.bodyLarge,
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
                              final currentCalorieDensityItem = state.data.getCalorieDensityItem(value);

                              if (state.data.calorieDensityValues.isEmpty ||
                                  currentCalorieDensityItem == null) {
                                return const SizedBox();
                              }

                              return CustomText.w400(
                                currentCalorieDensityItem.text,
                                style: context.textTheme.bodySmall,
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
              CustomText.bitter600(
                '${LocalizedTexts.whatIsCalorieDensity.translation}?',
                style: context.textTheme.displayMedium,
              ),
              const SizedBox(height: 8.0),
              CustomText.w400(
                LocalizedTexts.calorieDensityExplanationOne.translation,
                style: context.textTheme.bodySmall,
              ),
              const SizedBox(height: 16.0),
              CustomText.w400(
                LocalizedTexts.calorieDensityExplanationTwo.translation,
                style: context.textTheme.bodySmall,
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
