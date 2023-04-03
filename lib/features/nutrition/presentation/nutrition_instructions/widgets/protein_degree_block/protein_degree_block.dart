import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

class ProteinDegreeBlock extends StatelessWidget {
  const ProteinDegreeBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          nutritionInstructions: (state) {
            final currentProteinDegreeItem = state.currentProteinDegreeItem;

            if (state.proteinDegreeValues.isEmpty ||
                currentProteinDegreeItem == null) {
              return const SizedBox();
            }

            return GestureDetector(
              onTap: () => _onItemPressed(context),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalizedTexts.proteinDegree.translation
                              .toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontSize: 12.0,
                                  ),
                        ),
                        Text(
                          '${state.proteinDegreeValue}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          currentProteinDegreeItem.label
                              .capitalizeOnlyFirstLetter(),
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontSize: 14.0,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
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
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  _onItemPressed(BuildContext context) {
    context.router.push(NutritionInstructionsRoute(tabIndex: 1));
  }
}
