import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/double_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/summary_item.dart';

class Summary extends StatelessWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(recipeInfo: (s) {
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
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
              const NutritionBlock(),
              const SizedBox(
                height: 30.0,
              ),
              MainContainer(
                child: OutlinedRoundedButton(
                  text: LocalizedTexts.addFoodItem.translation,
                  icon: AppIcons.dish,
                  onPressed: () {},
                ),
              ),
            ],
          );
        }, orElse: () => const SizedBox.shrink(),);
      },
    );
  }
}
