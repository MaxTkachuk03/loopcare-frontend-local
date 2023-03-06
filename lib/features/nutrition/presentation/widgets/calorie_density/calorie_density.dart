import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/calorie_dencity_scale_layout.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/nutrition_value.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/instructions_block/instructions_block.dart';

class CalorieDensity extends StatelessWidget {
  const CalorieDensity({Key? key}) : super(key: key);

  _calorieDensityFilter(density) => (NutritionValue el) {
        final double doubleMinValue = double.parse(el.minValue);
        final double doubleMaxValue = double.parse(el.maxValue);

        return doubleMinValue <= density && density <= doubleMaxValue;
      };

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
                child: CalorieDensityScale(
                  // TODO get value from the bloc
                  density: 1,
                  separatorColor: AppColors.white,
                  layout: CalorieDensityScaleLayout.vertical,
                ),
              ),
              const SizedBox(width: 24.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO get value from the bloc
                    Text(
                      '${LocalizedTexts.calorieDensity.translation}: 1',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    BlocBuilder<NutritionBloc, NutritionState>(
                        builder: (BuildContext context, state) {
                      const density = 2; // TODO  get from the other bloc

                      var currentValue = state.calorieDensityValues
                          .firstWhere(_calorieDensityFilter(density));

                      print(currentValue);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            currentValue.label.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: AppColors.blueDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            currentValue.text,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      );
                    }),
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
