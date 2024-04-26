import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_values.dart';
import 'package:loopcare_frontend/core/domain/carb_fiber_ratio_values.dart';
import 'package:loopcare_frontend/core/domain/protein_degree_scale_values.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/nutrition_summary/nutrition_scale.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';

class NutritionSummary extends StatelessWidget {
  final double? calorieDensity;
  final double? proteinDegree;
  final double? fiber;
  final double? carbFiberRatio;

  const NutritionSummary(
      {super.key, this.calorieDensity, this.proteinDegree, this.fiber, this.carbFiberRatio});

  String get proteinDegreeLabel => '${proteinDegree?.round()}%';

  String get calorieDensityLabel => '${calorieDensity?.toStringAsFixed(1)}';

  String get fiberLabel => '${fiber?.toStringAsFixed(1)}g';

  @override
  Widget build(BuildContext context) {
    print(carbFiberRatio?.toStringAsFixed(2));
    return BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          orElse: () => const SizedBox.shrink(),
          loading: (_) => const Loader(),
          loaded: (state) {
            final currentCalorieDensityItem = state.data.getCalorieDensityItem(calorieDensity);

            if (state.data.calorieDensityValues.isEmpty || currentCalorieDensityItem == null) {
              return const SizedBox();
            }

            final currentProteinDegreeItem = state.data.getProteinDegreeItem(proteinDegree);

            if (state.data.proteinDegreeValues.isEmpty || currentProteinDegreeItem == null) {
              return const SizedBox();
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NutritionScale(
                  topLabel: LocalizedTexts.calorieDensity.tr(),
                  bottomLabel: currentCalorieDensityItem.label.capitalize(),
                  color: calorieDensityScaleValuesColorForRange(calorieDensity),
                  indicatorLabel: calorieDensityLabel,
                  isDisabled: calorieDensity == 0,
                ),
                NutritionScale(
                  topLabel: LocalizedTexts.proteinDegree.tr(),
                  bottomLabel: currentProteinDegreeItem.label.capitalize(),
                  color: proteinDegreeColor(30),
                  indicatorLabel: proteinDegreeLabel,
                  isDisabled: proteinDegree == 0,
                ),
                NutritionScale(
                  topLabel: LocalizedTexts.fiber.tr().capitalize(),
                  bottomLabel: currentProteinDegreeItem.label.capitalize(),
                  color: carbFiberRatioColor(carbFiberRatio),
                  indicatorLabel: fiberLabel,
                  isDisabled: fiber == 0,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
