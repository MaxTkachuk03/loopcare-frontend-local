import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/protein_degree_scale_values.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/custom_calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';

class ProteinDegreeBlock extends StatelessWidget {
  final double? value;
  final void Function({required int tabIndex}) onPress;
  final bool showArrow;

  const ProteinDegreeBlock({
    super.key,
    this.value,
    required this.onPress,
    required this.showArrow,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          loaded: (state) {
            final currentProteinDegreeItem = state.data.getProteinDegreeItem(value);

            if (state.data.proteinDegreeValues.isEmpty || currentProteinDegreeItem == null) {
              return const SizedBox();
            }

            final proteinDegreeValue = value == null || value == 0 ? '-' : '${value?.round()}%';

            return GestureDetector(
              onTap: () => _onItemPressed(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText.w600(
                    LocalizedTexts.proteinDegree.tr(),
                    style: context.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8.0),
                  CustomCalorieDensityScale(
                    density: value,
                    label: proteinDegreeValue,
                    color: value == null || value == 0 ? AppColors.white : proteinDegreeColor(value),
                    layoutSize: CustomCalorieDensityScaleLayoutSize.small,
                  ),
                  const SizedBox(height: 8.0),
                  if (value != null && value! > 0)
                    CustomText.w600(
                      currentProteinDegreeItem.label.capitalize(),
                      style: context.textTheme.bodySmall,
                    ),
                ],
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  _onItemPressed(BuildContext context) {
    onPress(tabIndex: 1);
  }
}
