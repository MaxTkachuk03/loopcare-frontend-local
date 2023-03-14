import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_layout.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/nutrition_instructions/application/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/nutrition_instructions/presentation/widgets/instructions_block/instructions_block.dart';

class CalorieDensity extends StatelessWidget {
  const CalorieDensity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: BlocBuilder<NutritionInstructionsBloc,
                    NutritionInstructionsState>(
                  builder: (BuildContext context, state) {
                    return CalorieDensityScale(
                      density: state.calorieDensityValue,
                      separatorColor: AppColors.white,
                      layout: CalorieDensityScaleLayout.vertical,
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
                    BlocBuilder<NutritionInstructionsBloc,
                        NutritionInstructionsState>(
                      builder: (BuildContext context, state) {
                        return Text(
                          '${LocalizedTexts.calorieDensity.translation}: ${state.calorieDensityValue}',
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        );
                      },
                    ),
                    const SizedBox(height: 8.0),
                    BlocBuilder<NutritionInstructionsBloc,
                        NutritionInstructionsState>(
                      builder: (BuildContext context, state) {
                        if (state.calorieDensityValues.isEmpty) {
                          return const SizedBox();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              state.currentCalorieDensityItem.label
                                  .toUpperCase(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: AppColors.blueDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              state.currentCalorieDensityItem.text,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
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
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              LocalizedTexts.calorieDensityExplanationOne.translation,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 16.0),
            Text(
              LocalizedTexts.calorieDensityExplanationTwo.translation,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 52.0),
            const InstructionsBlock(),
          ],
        ),
      ],
    );
  }
}
