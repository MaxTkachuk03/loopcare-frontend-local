import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/custom_calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';

class InstructionsBlock extends StatelessWidget {
  const InstructionsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    CustomText.w700(
                      'A',
                      style: context.textTheme.bodyMedium,
                    ),
                    Align(
                      child: AppImages.calorieDensityFoodA,
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                const CustomCalorieDensityScale(
                  density: 2.1,
                  label: '2.1',
                  layoutSize: CustomCalorieDensityScaleLayoutSize.small,
                ),
                const SizedBox(height: 4.0),
                BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
                  builder: (BuildContext context, state) {
                    return state.maybeMap(
                      loaded: (state) {
                        final item = state.data.getCalorieDensityItem(2.1);

                        if (state.data.calorieDensityValues.isEmpty || item == null) {
                          return const SizedBox();
                        }

                        return CustomText.w400(
                          item.label.capitalize(),
                          style: context.textTheme.titleSmall,
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    CustomText.w700(
                      'B',
                      style: context.textTheme.bodyMedium,
                    ),
                    Align(
                      child: AppImages.calorieDensityFoodB,
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                const CustomCalorieDensityScale(
                  density: 1.4,
                  label: '1.4',
                  layoutSize: CustomCalorieDensityScaleLayoutSize.small,
                ),
                const SizedBox(height: 4.0),
                BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
                  builder: (BuildContext context, state) {
                    return state.maybeMap(
                      loaded: (state) {
                        final item = state.data.getCalorieDensityItem(1.4);

                        if (state.data.calorieDensityValues.isEmpty || item == null) {
                          return const SizedBox();
                        }

                        return CustomText.w400(
                          item.label.capitalize(),
                          style: context.textTheme.titleSmall,
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
