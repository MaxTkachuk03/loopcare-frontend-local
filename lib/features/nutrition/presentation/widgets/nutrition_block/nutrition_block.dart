import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_layout.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions_bloc.dart';

class NutritionBlock extends StatelessWidget {
  const NutritionBlock({Key? key}) : super(key: key);

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
                    child: BlocBuilder<NutritionInstructionsBloc,
                        NutritionInstructionsState>(
                      builder: (BuildContext context, state) {
                        return CalorieDensityScale(
                          density: state.calorieDensityValue,
                          layout: CalorieDensityScaleLayout.vertical,
                          separatorColor: AppColors.bgGreen,
                          separatorSize: 1,
                        );
                      },
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
                      BlocBuilder<NutritionInstructionsBloc,
                          NutritionInstructionsState>(
                        builder: (BuildContext context, state) {
                          return Text(
                            '${state.calorieDensityValue}',
                            style: Theme.of(context).textTheme.bodyText2,
                          );
                        },
                      ),
                      Row(
                        children: [
                          BlocBuilder<NutritionInstructionsBloc,
                              NutritionInstructionsState>(
                            builder: (BuildContext context, state) {
                              if (state.calorieDensityValues.isEmpty) {
                                return const SizedBox();
                              }

                              return Text(
                                state.currentCalorieDensityItem.label,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: 14.0,
                                    ),
                              );
                            },
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
                    BlocBuilder<NutritionInstructionsBloc,
                        NutritionInstructionsState>(
                      builder: (BuildContext context, state) {
                        return Text(
                          '${state.proteinDegreeValue}',
                          style: Theme.of(context).textTheme.bodyText2,
                        );
                      },
                    ),
                    Row(
                      children: [
                        BlocBuilder<NutritionInstructionsBloc,
                            NutritionInstructionsState>(
                          builder: (BuildContext context, state) {
                            if (state.proteinDegreeValues.isEmpty) {
                              return const SizedBox();
                            }

                            return Text(
                              state.currentProteinDegreeItem.label,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontSize: 14.0,
                                  ),
                            );
                          },
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
    context.router.push(NutritionValueRoute(tabIndex: tabIndex));
  }
}
