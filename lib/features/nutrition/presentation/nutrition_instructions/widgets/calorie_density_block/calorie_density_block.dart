import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_layout.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

class CalorieDensityBlock extends StatelessWidget {
  final double? value;
  final void Function({required int tabIndex}) onPress;
  final bool showArrow;

  const CalorieDensityBlock({
    Key? key,
    this.value,
    required this.onPress,
    required this.showArrow,
  }) : super(key: key);

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

              return GestureDetector(
                onTap: () => _onItemPressed(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 15.0,
                      height: 55.0,
                      child: CalorieDensityScale(
                        density: value,
                        layout: CalorieDensityScaleLayout.vertical,
                        separatorColor: AppColors.bgGreen,
                        separatorSize: 1,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalizedTexts.calorieDensity.translation.toUpperCase(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 12.0,
                              ),
                        ),
                        Text(
                          value?.toStringAsFixed(2) ?? '-',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if (value != null)
                          Text(
                            currentCalorieDensityItem.label.capitalizeOnlyFirstLetter(),
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 14.0,
                                ),
                          )
                      ],
                    ),
                    if (showArrow)
                      const SizedBox(
                        width: 8.0,
                      ),
                    if (showArrow)
                      const SizedBox(
                        width: 10,
                        height: 14,
                        child: ImageIcon(
                          AppIcons.arrow,
                          color: AppColors.darkGreen,
                        ),
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
