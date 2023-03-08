import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_layout.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/nutrition_value.dart';

class NutritionBlock extends StatelessWidget {
  final double calorieDensityValue;
  final double proteinDegreeValue;
  final NutritionValue currentCalorieDensityItem;
  final NutritionValue currentProteinDegreeItem;

  const NutritionBlock({
    Key? key,
    required this.calorieDensityValue,
    required this.proteinDegreeValue,
    required this.currentCalorieDensityItem,
    required this.currentProteinDegreeItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      height: 105.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _onItemPressed(context, tabIndex: 0),
              child: Row(
                children: [
                  SizedBox(
                    width: 15.0,
                    height: 55.0,
                    child: CalorieDensityScale(
                      density: calorieDensityValue,
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
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 12.0,
                            ),
                      ),
                      Text(
                        '$calorieDensityValue',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Row(
                        children: [
                          Text(
                            currentCalorieDensityItem.label,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: 14.0,
                                    ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const VerticalDivider(
            color: AppColors.yellowLight,
            width: 1.0,
            thickness: 1.0,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _onItemPressed(context, tabIndex: 1),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalizedTexts.proteinDegree.translation.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 12.0,
                          ),
                    ),
                    Text(
                      '$proteinDegreeValue',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Row(
                      children: [
                        Text(
                          currentProteinDegreeItem.label,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontSize: 14.0,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onItemPressed(BuildContext context, {required int tabIndex}) {
    context.router.push(
      NutritionValueRoute(
        calorieDensity: calorieDensityValue,
        proteinDegree: proteinDegreeValue,
        currentCalorieDensityItem: currentCalorieDensityItem,
        currentProteinDegreeItem: currentProteinDegreeItem,
        tabIndex: tabIndex,
      ),
    );
  }
}
