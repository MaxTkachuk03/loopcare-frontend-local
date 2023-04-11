import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal/widgets/meal_nutrition_values.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal/widgets/meals_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';

import 'package:loopcare_frontend/features/nutrition/presentation/widgets/plus_button_hexagon/plus_button_hexagon.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  @override
  void initState() {
    context.read<MealsBloc>().add(const MealsEvent.fetchMeals());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
        builder: (BuildContext context, state) {
      return Scaffold(
        appBar: BlueAppBar(
          isCustomLeading: true,
          title: state.currentMealCategory != null
              ? '${state.currentMealCategory} ${LocalizedTexts.logList.translation} today'
              : '${LocalizedTexts.logList.translation} today',
          actions: const [PlusButtonHexagon()],
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const MealNutritionValues(),
                    const MealsList(),
                    const NutritionBlock(),
                    const SizedBox(height: 26.0),
                    MainContainer(
                      child: Row(
                        children: [
                          OutlinedRoundedButton(
                            text: LocalizedTexts.saveToMyDishes.translation,
                            icon: AppIcons.dish,
                          ),
                          const SizedBox(width: 8.0),
                          OutlinedRoundedButton(
                            text: LocalizedTexts.deleteMeal.translation,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    MainContainer(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(LocalizedTexts.backToDashboard.translation),
                      ),
                    ),
                    const SizedBox(height: 20.0)
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
