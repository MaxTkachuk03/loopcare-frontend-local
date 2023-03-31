import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal_list/widgets/empty_meal.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal_list/widgets/meal_nutrition_values.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_list/food_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/plus_button_hexagon/plus_button_hexagon.dart';

class MealPage extends StatelessWidget {
  const MealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        isCustomLeading: true,
        title: 'Lunch ${LocalizedTexts.logList.translation} today',
        actions: const [PlusButtonHexagon()],
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EmptyMeal(),
              // Column(
              //   children: [
              //     const MealNutritionValues(),
              //     const FoodList(
              //       list: [1, 2, 3],
              //     ),
              //     const NutritionBlock(),
              //     const SizedBox(
              //       height: 26.0,
              //     ),
              //     MainContainer(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           OutlinedRoundedButton(
              //             text: LocalizedTexts.saveToMyDishes.translation,
              //             icon: AppIcons.dish,
              //             // onPressed: () {},
              //           ),
              //           const SizedBox(
              //             width: 8.0,
              //           ),
              //           OutlinedRoundedButton(
              //             text: LocalizedTexts.deleteMeal.translation,
              //             // icon: AppIcons.dish,
              //             onPressed: () {},
              //           )
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              Column(
                children: [
                  MainContainer(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(LocalizedTexts.backToDashboard.translation),
                    ),
                  ),
                  const SizedBox(height: 20.0,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
