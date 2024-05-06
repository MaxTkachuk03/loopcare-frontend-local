import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_summary/nutrition_summary.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/double_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_details/recipe_details.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/summary_item.dart';

class Summary extends StatelessWidget {
  final void Function() onAddToDishPress;
  final bool fromRecommendation;

  const Summary({
    super.key,
    required this.onAddToDishPress,
    required this.fromRecommendation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          recipeInfo: (s) {
            return ScrollableContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0),
                        CustomText.bitter600(
                          s.recipe.name,
                          style: context.textTheme.displayMedium,
                        ),
                        const SizedBox(height: 20.0),
                        CustomText.w400(
                          s.recipe.description,
                          style: context.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            SummaryItem(
                              label: LocalizedTexts.cookingTime.tr(),
                              icon: AppIcons.clockGrey,
                              quantity: '${s.recipe.cookingTimeMin}',
                              quantityLabel: 'min',
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            SummaryItem(
                              label: LocalizedTexts.preparation.tr(),
                              icon: AppIcons.clockGrey,
                              quantity: '${s.recipe.preparationTimeMin}',
                              quantityLabel: 'min',
                            ),
                            const SizedBox(
                              width: 30.0,
                            ),
                            SummaryItem(
                              label: LocalizedTexts.portions.tr(),
                              icon: const Icon(
                                Icons.person_outline_rounded,
                                color: AppColors.blueDarker,
                              ),
                              quantity: s.recipe.servingAmount.removeDecimalZeroFormat(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                      color: AppColors.greenLighter,
                    ),
                    child: NutritionSummary(
                      proteinDegree: s.recipe.proteinDegreeVal,
                      calorieDensity: s.recipe.calorieDensityVal,
                      fiber: s.recipe.fiberSum,
                      carbFiberRatio: s.recipe.carbFiberRatio,
                      carbsPercent: s.recipe.carbsPercent,
                      totalCalories: s.recipe.servingCalories,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  MainContainer(
                    child: CustomOutlinedButton.blueSmall(
                      label: LocalizedTexts.addToMyDishes.tr(),
                      onPressed: onAddToDishPress,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  //Todo hide "Skip" button LOOPCARE-2175
                  // MainContainer(child: _getButton(context, fromRecommendation, s.recipe)),
                  // const SizedBox(height: 20.0)
                ],
              ),
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
      return CustomElevatedButton.blueFullWidth(
        onPressed: () => _onPlanThisMealTap(context, item),
        label: LocalizedTexts.planThisMeal.tr(),
      );
    }

    return CustomElevatedButton.blueFullWidth(
      onPressed: () => context.router.pop(),
      label: LocalizedTexts.skip.tr(),
    );
  }
}
