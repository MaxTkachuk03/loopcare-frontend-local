import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish/dish.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dish_details_page/widgets/dish_list/dish_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/servings_amount/servings_amount.dart';

class DishDetailsPage extends StatefulWidget {
  final Dish selectedDish;

  const DishDetailsPage({
    Key? key,
    required this.selectedDish,
  }) : super(key: key);

  @override
  State<DishDetailsPage> createState() => _DishDetailsPageState();
}

class _DishDetailsPageState extends State<DishDetailsPage> {
  late TextEditingController _servingController = TextEditingController();

  @override
  void initState() {
    context.read<DishBloc>().add(DishEvent.setCurrentDish(widget.selectedDish));

    _servingController.text =
        widget.selectedDish.serving.numberOfUnits.toString();

    context.read<NutritionInstructionsBloc>()
      ..add(NutritionInstructionsEvent.setCalorieDensity(
        widget.selectedDish.calorieDensity,
      ))
      ..add(NutritionInstructionsEvent.setProteinDegree(
        widget.selectedDish.proteinDegree,
      ));

    super.initState();
  }

  @override
  void dispose() {
    _servingController.dispose();

    super.dispose();
  }

  void _onServingChanges(String val) {
    // TODO implement logic on serving update
  }

  void _onNutritionFactSelect(NutritionItem item) {
    context.read<DishBloc>().add(DishEvent.nutritionItemChanged(item));
  }

  void _onAddFoodItemHandler() {
    // TODO implement adding food item logic
  }

  void _onEditDishHandler() {
    // TODO implement edit dish logic
  }

  void _dishListener(BuildContext context, DishState state) {
    final dishState = state.mapOrNull(dish: (s) => s.selectedDish);

    if (dishState == null) return;

    _servingController =
        TextEditingController(text: dishState.serving.numberOfUnits.toString());

    context.read<NutritionInstructionsBloc>()
      ..add(
          NutritionInstructionsEvent.setProteinDegree(dishState.proteinDegree))
      ..add(NutritionInstructionsEvent.setCalorieDensity(
          dishState.calorieDensity));
  }

  _onLogDishHandler() {
    final mealId = context.read<MealsBloc>().state.getCurrentMealId;

    if (mealId == null) return;

    final numberOfServings = _servingController.text;

    context.read<DishBloc>().add(DishEvent.addToMeal(mealId, numberOfServings));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DishBloc, DishState>(
          listener: _dishListener,
          listenWhen: (previous, current) =>
              previous is Loading && current is Dish,
        ),
      ],
      child: Scaffold(
        appBar: BlueAppBar(
          isCustomLeading: true,
          title: widget.selectedDish.name,
          subtitle: LocalizedTexts.myDish.translation,
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: BlocBuilder<DishBloc, DishState>(
              builder: (BuildContext context, state) {
                return state.maybeMap(
                    loading: (_) => const Loader(),
                    dish: (dishState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              ServingsAmount(
                                inputController: _servingController,
                                onValueChangeHandler: _onServingChanges,
                              ),
                              NutritionValuesBlock(
                                numberOfPortions: dishState
                                    .selectedDish.numberOfServings
                                    .toInt(),
                                nutritionValue:
                                    dishState.currentNutritionItem.value,
                                nutritionValuesList:
                                    dishState.selectedDish.serving.list,
                                selectedNutritionItem:
                                    dishState.currentNutritionItem,
                                onNutritionFactSelect: _onNutritionFactSelect,
                              ),
                              DishList(
                                list: dishState.selectedDish.foodItems,
                                nutritionKey:
                                    dishState.currentNutritionItem.key,
                              ),
                              const NutritionBlock(),
                              const SizedBox(height: 26.0),
                              MainContainer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        OutlinedRoundedButton(
                                          text: LocalizedTexts
                                              .addFoodItem.translation,
                                          icon: AppIcons.plus,
                                          onPressed: _onAddFoodItemHandler,
                                        ),
                                        const SizedBox(width: 16.0),
                                        OutlinedRoundedButton(
                                          text: LocalizedTexts
                                              .editMyDish.translation,
                                          icon: AppIcons.edit,
                                          onPressed: _onEditDishHandler,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          MainContainer(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: _onLogDishHandler,
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style
                                      ?.copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                AppColors.orangeDark),
                                      ),
                                  child: Text(
                                    LocalizedTexts.logItem.translation,
                                  ),
                                ),
                                const SizedBox(height: 30.0),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    orElse: () => const SizedBox.shrink());
              },
            ),
          ),
        ),
      ),
    );
  }
}
