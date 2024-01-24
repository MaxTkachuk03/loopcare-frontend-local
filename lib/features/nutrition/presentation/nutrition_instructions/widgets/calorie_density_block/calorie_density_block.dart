import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_values.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/custom_calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';

class CalorieDensityBlock extends StatelessWidget {
  final double? value;
  final void Function({required int tabIndex}) onPress;

  const CalorieDensityBlock({
    super.key,
    this.value,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
            loaded: (state) {
              final currentCalorieDensityItem = state.data.getCalorieDensityItem(value);

              if (state.data.calorieDensityValues.isEmpty || currentCalorieDensityItem == null) {
                return const SizedBox();
              }
              final calorieDegreeValue = value == null || value == 0 ? '-' : value!.toStringAsFixed(1);
              return GestureDetector(
                onTap: () => _onItemPressed(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText.w600(
                      LocalizedTexts.calorieDensity.tr(),
                      style: context.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8.0),
                    CustomCalorieDensityScale(
                      density: value,
                      label: calorieDegreeValue,
                      color: value == null || value == 0
                          ? AppColors.white
                          : calorieDensityScaleValuesColorForRange(value),
                      layoutSize: CustomCalorieDensityScaleLayoutSize.small,
                    ),
                    const SizedBox(height: 8.0),
                    if (value != null && value! > 0)
                      CustomText.w600(
                        currentCalorieDensityItem.label.capitalize(),
                        style: context.textTheme.bodySmall,
                      ),
                  ],
                ),
              );
            },
            orElse: () => const SizedBox.shrink());
      },
    );
  }

  _onItemPressed(BuildContext context) {
    onPress(tabIndex: 0);
  }
}
