import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dish_details_page/widgets/dish_list/dish_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/servings_amount/servings_amount.dart';

class DishDetailsPage extends StatefulWidget {
  final int dishId;
  final bool canEditDish;

  const DishDetailsPage({
    Key? key,
    required this.dishId,
    required this.canEditDish,
  }) : super(key: key);

  @override
  State<DishDetailsPage> createState() => _DishDetailsPageState();
}

class _DishDetailsPageState extends State<DishDetailsPage> {
  late TextEditingController _servingController = TextEditingController();

  @override
  void initState() {
    final dishBloc = context.read<DishBloc>();

    dishBloc.add(DishEvent.getClonedDish(widget.dishId));

    _servingController =
        TextEditingController(text: dishBloc.state.servingAmount);

    super.initState();
  }

  @override
  void dispose() {
    _servingController.dispose();

    super.dispose();
  }

  void _onServingChanges(String _) {}

  void _onNutritionFactSelect(NutritionValuesTypes item) {
    context.read<DishBloc>().add(DishEvent.nutritionItemChanged(item));
  }

  void _selectServingOnConfirmHandler(
    double numberOfUnits,
    String servingId,
    String externalFoodItemId,
  ) {
    context.read<DishBloc>().add(
          DishEvent.addFoodItemToDish(
            numberOfUnits: numberOfUnits,
            servingId: servingId,
            externalFoodItemId: externalFoodItemId,
          ),
        );

    showAppSnackBar(
      context: context,
      background: AppColors.white,
      text: LocalizedTexts.foodItemWasAddedToDish.translation,
    );

    context.router.popUntilRouteWithName(SearchRoute.name);
  }

  void _onAddFoodItemHandler() {
    context.router.push(
      SearchRoute(
        mode: SearchMode.food,
        onItemTap: (SearchItem item) {
          final mealBloc = context.read<MealsBloc>();
          final mealId = mealBloc.state.getCurrentMealId;

          if (mealId == null) return;

          context.router.push(
            SelectServingRoute(
              foodItemId: item.id,
              foodItemName: item.name,
              initialServingAmount: 1,
              onConfirm: (
                double numberOfUnits,
                String servingId,
              ) =>
                  _selectServingOnConfirmHandler(
                numberOfUnits,
                servingId,
                item.id,
              ),
            ),
          );
        },
      ),
    );
  }

  _onLogDishHandler() {
    final mealId = context.read<MealsBloc>().state.getCurrentMealId;

    if (mealId == null) return;

    final numberOfServings =
        _servingController.text.replaceCommaWithDot.deleteDotAtTheEnd;

    context.read<DishBloc>().add(DishEvent.addToMeal(mealId, numberOfServings));

    context.router.pushNamed(AppRoutes.meal);
  }

  void _onEditDishHandler() {
    final state = context.read<DishBloc>().state;
    final id = state.mapOrNull(dish: (s) => s.originalDishId);
    final name = state.mapOrNull(dish: (s) => s.selectedDish.name);

    if (id == null || name == null) return;

    context.router.push(EditDishRoute(
      event: EditDishEvent.getDish(id),
      mode: EditDishPageMode.edit,
    ));
  }

  void _onDeleteFoodItemPressed(BuildContext context, FoodItem item) {
    final dishId = context
        .read<DishBloc>()
        .state
        .mapOrNull(dish: (s) => s.selectedDish.id);

    if (dishId == null) return;

    context.read<DishBloc>().add(DishEvent.deleteFoodItemFromDish(
          dishId: dishId,
          internalFoodItemId: int.parse(item.id),
        ));

    showAppSnackBar(
      context: context,
      background: AppColors.white,
      text: LocalizedTexts.foodItemWasDeletedFromDish.translation,
    );
  }

  void _onFoodItemPressed(BuildContext context, DishFoodItem item) {
    final servingId = item.serving.servingId;

    if (servingId == null) return;

    context.router.push(
      SelectServingRoute(
        foodItemId: item.externalId,
        initialServingId: servingId,
        initialServingAmount: item.serving.numberOfUnits,
        foodItemName: item.foodName,
        onConfirm: (double numberOfUnits, String servingId) {
          final dishId = context
              .read<DishBloc>()
              .state
              .mapOrNull(dish: (s) => s.selectedDish.id);

          if (dishId == null) return;

          context.read<DishBloc>().add(
                DishEvent.updateFoodItemInDish(
                  dishId: dishId,
                  internalFoodItemId: item.id.toString(),
                  numberOfUnits: numberOfUnits,
                  servingId: servingId,
                ),
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        isCustomLeading: true,
        title: context.watch<DishBloc>().state.mapOrNull(
              dish: (s) => s.selectedDish.name,
            ),
        subtitle: LocalizedTexts.myDish.translation,
      ),
      body: SafeArea(
        child: BlocBuilder<DishBloc, DishState>(
          builder: (BuildContext context, state) {
            return state.maybeMap(
                loading: (_) => const Loader(),
                dish: (dishState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ServingsAmount(
                              inputController: _servingController,
                              onValueChangeHandler: _onServingChanges,
                            ),
                            NutritionValuesBlock(
                              numberOfPortions: dishState
                                  .selectedDish.numberOfServings
                                  .toInt(),
                              nutritionValuesList:
                                  dishState.selectedDish.serving.list,
                              selectedNutritionType:
                                  dishState.currentNutritionType,
                              onNutritionFactSelect: _onNutritionFactSelect,
                            ),
                            Expanded(
                              child: DishList(
                                list: dishState.selectedDish.foodItems,
                                nutritionKey:
                                    dishState.currentNutritionType.name,
                                onDeleteHandler: _onDeleteFoodItemPressed,
                                onListItemTapHandler: _onFoodItemPressed,
                                isScrollable: true,
                              ),
                            ),
                            NutritionBlock(
                              calorieDensity:
                                  dishState.selectedDish.calorieDensity,
                              proteinDegree:
                                  dishState.selectedDish.proteinDegree,
                            ),
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
                                      if (widget.canEditDish)
                                        OutlinedRoundedButton(
                                            text: LocalizedTexts
                                                .editMyDish.translation,
                                            icon: AppIcons.edit,
                                            onPressed:
                                                _onEditDishHandler // disable for now,
                                            )
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      MainContainer(
                        child: Column(
                          children: [
                            BlocBuilder<DishBloc, DishState>(
                                builder: (BuildContext context, state) {
                              return state.maybeMap(
                                  dish: (dishState) {
                                    return ElevatedButton(
                                      onPressed: dishState.hasFoodItems
                                          ? _onLogDishHandler
                                          : null,
                                      child: Text(
                                        LocalizedTexts.logItem.translation,
                                      ),
                                    );
                                  },
                                  orElse: () => const SizedBox.shrink());
                            }),
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
    );
  }
}
