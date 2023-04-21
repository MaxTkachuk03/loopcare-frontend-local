import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_layout.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

class CalorieBlock extends StatelessWidget {
  const CalorieBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
            nutritionInstructions: (state) {
              final currentCalorieDensityItem = state.currentCalorieDensityItem;

              if (state.calorieDensityValues.isEmpty ||
                  currentCalorieDensityItem == null) {
                return const SizedBox();
              }

              return GestureDetector(
                onTap: () => _onItemPressed(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocalizedTexts.calorieDensity.translation
                              .toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: ThemeConstants.fontSize12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.greyLabel,
                                  ),
                        ),
                        const SizedBox(width: 4.0),
                        const ImageIcon(
                          AppIcons.arrow,
                          color: AppColors.greyLabel,
                          size: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      currentCalorieDensityItem.label
                          .capitalizeOnlyFirstLetter(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 14.0,
                          ),
                    ),
                    const SizedBox(height: 5.0),
                    SizedBox(
                      height: 22.0,
                      child: CalorieDensityScale(
                        density: state.calorieDensityValue,
                        layout: CalorieDensityScaleLayout.horizontal,
                        separatorColor: AppColors.bgGreen,
                        separatorSize: 1,
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
    context.router.push(NutritionInstructionsRoute(tabIndex: 0));
  }
}
