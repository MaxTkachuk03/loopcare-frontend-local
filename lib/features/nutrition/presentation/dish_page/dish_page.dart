import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/servings_amount/servings_amount.dart';

class DishPage extends StatefulWidget {
  const DishPage({Key? key}) : super(key: key);

  @override
  State<DishPage> createState() => _DishPageState();
}

class _DishPageState extends State<DishPage> {
  final TextEditingController _servingController =
      TextEditingController(text: '1');

  @override
  void initState() {
    context.read<NutritionInstructionsBloc>()
      ..add(const NutritionInstructionsEvent.setCalorieDensity(2.0))
      ..add(const NutritionInstructionsEvent.setProteinDegree(50.0));

    super.initState();
  }

  @override
  void dispose() {
    _servingController.dispose();

    super.dispose();
  }

  void _onServingChanges(String val) {
    print(val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        isCustomLeading: true,
        title: 'Roasted Cauliflower and le...',
        subtitle: LocalizedTexts.myDish.translation,
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ServingsAmount(
                inputController: _servingController,
                onValueChangeHandler: _onServingChanges,
              ),
              NutritionValuesBlock(
                numberOfPortions: 4,
                nutritionValue: 21,
                nutritionValuesList: [],
                selectedNutritionItem:
                    NutritionItem(name: '', key: '', unitLabel: ''),
                onNutritionFactSelect: (NutritionItem item) {},
              ),
              // const FoodList(
              //   list: [1, 2, 3],
              // ),
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
                          text: LocalizedTexts.editMyDish.translation,
                          icon: AppIcons.edit,
                          onPressed: () {},
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
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
