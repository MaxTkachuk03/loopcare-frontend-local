import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_layout.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/nutrition_value.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/instructions_block/instructions_block.dart';

class CalorieDensity extends StatelessWidget {
  final double calorieDensity;
  final NutritionValue currentCalorieDensityItem;

  const CalorieDensity({
    Key? key,
    required this.calorieDensity,
    required this.currentCalorieDensityItem,
  }) : super(key: key);

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
                  density: calorieDensity,
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
                    Text(
                      '${LocalizedTexts.calorieDensity.translation}: $calorieDensity',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      currentCalorieDensityItem.label.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: AppColors.blueDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      currentCalorieDensityItem.text,
                      style: Theme.of(context).textTheme.bodyText2,
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
