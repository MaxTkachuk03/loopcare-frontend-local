import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/custom_calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';

class ProteinDegree extends StatelessWidget {
  final double? value;

  const ProteinDegree({
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
                  builder: (BuildContext context, state) {
                    return state.maybeMap(
                      loaded: (state) {
                        final currentProteinDegreeItem = state.data.getProteinDegreeItem(value);

                        if (state.data.proteinDegreeValues.isEmpty || currentProteinDegreeItem == null) {
                          return const SizedBox();
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  CustomCalorieDensityScale(
                                    density: value,
                                    label: '${value?.toStringAsFixed(0) ?? ''}%',
                                  ),
                                  const SizedBox(height: 8.0),
                                  CustomText.w600(
                                    currentProteinDegreeItem.label.capitalize(),
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: CustomText.w400(
                                currentProteinDegreeItem.text,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
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
              CustomText.bitter600(
                '${LocalizedTexts.whatIsProtein.translation}?',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8.0),
              CustomText.w400(
                LocalizedTexts.calorieDensityExplanationOne.translation,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16.0),
              CustomText.w400(
                LocalizedTexts.calorieDensityExplanationTwo.translation,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
