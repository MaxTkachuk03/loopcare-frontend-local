import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dish_details_page/widgets/dish_list/dish_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/servings_amount/servings_amount.dart';

class CreateDishPage extends StatefulWidget {
  final int? id;

  const CreateDishPage({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<CreateDishPage> createState() => _CreateDishPageState();
}

class _CreateDishPageState extends State<CreateDishPage> {
  late TextEditingController _servingController = TextEditingController();

  @override
  void initState() {
    _servingController.text = '1';
    if (widget.id == null) return;
    // TODO get dish from the server by ID

    super.initState();
  }

  void _onServingChanges(String value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        isCustomLeading: true,
        title: '${LocalizedTexts.addToMyDishedAs.translation}:',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              color: AppColors.blueAppBar,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: LocalizedTexts.giveNameToThisDish.translation,
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.greyLabel,
                      ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ServingsAmount(
                    inputController: _servingController,
                    onValueChangeHandler: _onServingChanges,
                  ),
                  NutritionValuesBlock(
                    numberOfPortions: 4,
                    nutritionValue: 20.0,
                    nutritionValuesList: const [],
                    selectedNutritionItem: const NutritionItem(
                        name: '', key: '', value: 10.0, unitLabel: ''),
                    onNutritionFactSelect: (NutritionItem item) {},
                  ),
                  Expanded(
                    child: DishList(
                      list: [],
                      nutritionKey: 'calories',
                      onDeleteHandler: (BuildContext context, FoodItem item) {},
                      onListItemTapHandler:
                          (BuildContext context, DishFoodItem item) {},
                    ),
                  ),
                  const NutritionBlock(
                    calorieDensity: 10.0,
                    proteinDegree: 20.0,
                  ),
                  const SizedBox(height: 26.0),
                  MainContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            OutlinedRoundedButton(
                              text: LocalizedTexts.addFoodItem.translation,
                              icon: AppIcons.plus,
                              onPressed: () {},
                            ),
                            const SizedBox(width: 16.0),
                            OutlinedRoundedButton(
                              text: LocalizedTexts.deleteDish.translation,
                              icon: AppIcons.delete,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            LocalizedTexts.save.translation,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
