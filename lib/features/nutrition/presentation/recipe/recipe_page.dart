import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_list/food_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/meal_portions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  void initState() {
    context.read<NutritionInstructionsBloc>()
      ..add(const NutritionInstructionsEvent.setCalorieDensity(2.0))
      ..add(const NutritionInstructionsEvent.setProteinDegree(50.0));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        isCustomLeading: true,
        title: 'Greek salad',
        subtitle: LocalizedTexts.recipe.translation,
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const MealPortions(),
              const FoodList(
                list: [1, 2, 3],
              ),
              const NutritionBlock(),
              const SizedBox(
                height: 26.0,
              ),
              MainContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedRoundedButton(
                          text: LocalizedTexts.addFoodItem.translation,
                          icon: AppIcons.plus,
                          onPressed: () {},
                        ),
                        OutlinedRoundedButton(
                          text: LocalizedTexts.saveToMyDishes.translation,
                          icon: AppIcons.dish,
                          onPressed: () {},
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    OutlinedRoundedButton(
                      text: LocalizedTexts.viewRecipe.translation,
                      icon: AppIcons.chef,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
