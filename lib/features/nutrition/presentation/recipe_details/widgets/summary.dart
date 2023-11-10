import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/double_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_details/recipe_details.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/summary_item.dart';

class Summary extends StatelessWidget {
  final void Function() onAddToDishPress;
  final bool fromRecommendation;

  const Summary({
    Key? key,
    required this.onAddToDishPress,
    required this.fromRecommendation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          recipeInfo: (s) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 18.0,
                    left: 24.4,
                    right: 24.0,
                    bottom: 30.0,
                  ),
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.recipe.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.black,
                            ),
                      ),
                      const SizedBox(height: 18.0),
                      Row(
                        children: [
                          SummaryItem(
                            label: LocalizedTexts.cookingTime.translation,
                            icon: AppIcons.clockGrey,
                            quantity: '${s.recipe.cookingTimeMin}',
                            quantityLabel: 'min',
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          SummaryItem(
                            label: LocalizedTexts.preparation.translation,
                            icon: AppIcons.clockGrey,
                            quantity: '${s.recipe.preparationTimeMin}',
                            quantityLabel: 'min',
                          ),
                          const SizedBox(
                            width: 30.0,
                          ),
                          SummaryItem(
                            label: LocalizedTexts.portions.translation,
                            icon: AppIcons.person,
                            quantity: s.recipe.servingAmount.removeDecimalZeroFormat(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: NutritionBlock(
                    calorieDensity: s.recipe.calorieDensity,
                    proteinDegree: s.recipe.proteinDegree,
                  ),
                ),
                if (!fromRecommendation) const SizedBox(height: 30.0),
                // if (fromRecommendation) const SizedBox(height: 20.0),
                // if (fromRecommendation)
                //   Padding(
                //     padding: const EdgeInsets.only(left: 24.0),
                //     child: OutlinedRoundedButton(
                //       text: LocalizedTexts.addToMyDishes.translation,
                //       icon: AppIcons.dish,
                //       onPressed: onAddToDishPress,
                //     ),
                //   ),
                Column(
                  children: [
                    const SizedBox(height: 26.0),
                    MainContainer(child: _getButton(context, fromRecommendation, s.recipe)),
                    const SizedBox(height: 20.0)
                  ],
                )
              ],
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  _onPlanThisMealTap(BuildContext context, RecipeDetails item) {
    context.router.push(
      RecipeRoute(
        id: int.parse(item.id.toString()),
        name: item.name,
      ),
    );
  }

  Widget _getButton(BuildContext context, bool fromRecommendation, RecipeDetails item) {
    if (fromRecommendation) {
      return ElevatedButton(
        onPressed: () => _onPlanThisMealTap(context, item),
        child: Text(LocalizedTexts.planThisMeal.translation),
      );
    }

    return ElevatedButton(
      onPressed: () => context.router.pop(),
      child: Text(LocalizedTexts.skip.translation),
    );
  }
}
