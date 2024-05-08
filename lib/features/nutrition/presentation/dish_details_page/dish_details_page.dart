import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_summary/nutrition_summary.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/utils/function_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dish_details_page/widgets/dish_list/dish_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/servings_amount/servings_amount.dart';

class DishDetailsPage extends StatefulWidget {
  final int dishId;
  final bool canEditDish;
  final bool? isMealDish;

  const DishDetailsPage({
    super.key,
    required this.dishId,
    required this.canEditDish,
    this.isMealDish,
  });

  @override
  State<DishDetailsPage> createState() => _DishDetailsPageState();
}

class _DishDetailsPageState extends State<DishDetailsPage> {
  late TextEditingController _servingController = TextEditingController();
  late double _servingsAmount;

  @override
  void initState() {
    final dishBloc = context.read<DishBloc>();

    if (widget.isMealDish ?? false) {
      dishBloc.add(DishEvent.getDishById(widget.dishId));
    } else {
      dishBloc.add(DishEvent.getClonedDish(widget.dishId));
    }

    _servingController = TextEditingController(text: dishBloc.state.servingAmount);

    _servingsAmount = double.parse(dishBloc.state.servingAmount);

    super.initState();
  }

  @override
  void dispose() {
    _servingController.dispose();
    super.dispose();
  }

  void _onServingChanges(String val) {
    setState(() {
      _servingsAmount = double.parse(val.isEmpty ? '0' : val);
    });

    _servingController.text = val;

    if (!(widget.isMealDish ?? false)) return;

    final mealState = context.read<MealsBloc>().state;
    final mealId = mealState.getCurrentMealId;

    if (mealId == null || val.isEmpty) return;

    context.read<DishBloc>().add(DishEvent.servingChanged(mealId: mealId, servingAmount: int.parse(val)));
  }

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

    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.foodLogged,
      parameters: {
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
        CustomDefinitions.mealId: externalFoodItemId,
        CustomDefinitions.servingId: servingId,
        CustomDefinitions.numberOfUnits: numberOfUnits.toString(),
        CustomDefinitions.isDishes: 'true',
      },
    );

    context.showSuccessBar(content: Text(LocalizedTexts.foodItemWasAddedToDish.tr()));
    context.router.popUntilRouteWithName(SearchRoute.name);
  }

  void _onAddFoodItemHandler() {
    FocusScope.of(context).unfocus();
    TextEditingController().clear();

    context.router.push(
      SearchRoute(
        mode: SearchMode.food,
        onItemTap: (SearchItem item) {
          final mealBloc = context.read<MealsBloc>();
          final mealId = mealBloc.state.getCurrentMealId;

          if (mealId == null) {
            debugPrint('Search item click freezed DishDetailsPage mealId == null');
            return;
          }

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

    final numberOfServings = _servingController.text.replaceCommaWithDot.deleteDotAtTheEnd;

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
    final dishId = context.read<DishBloc>().state.mapOrNull(dish: (s) => s.selectedDish.id);

    if (dishId == null) return;

    context.read<DishBloc>().add(DishEvent.deleteFoodItemFromDish(
          dishId: dishId,
          internalFoodItemId: int.parse(item.id),
        ));
    context.showSuccessBar(content: Text(LocalizedTexts.foodItemWasDeletedFromDish.tr()));
  }

  void _onFoodItemPressed(BuildContext context, DishFoodItem item) {
    final servingId = item.serving.servingId;

    if (servingId == null) return;

    context.router.push(
      SelectServingRoute(
        foodItemId: item.externalId,
        initialServingId: servingId,
        initialServingAmount: item.serving.numberOfUnits,
        initialCaloriesValue: item.serving.calories,
        foodItemName: item.foodName,
        onConfirm: (double numberOfUnits, String servingId) {
          final dishId = context.read<DishBloc>().state.mapOrNull(dish: (s) => s.selectedDish.id);

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
    return BlocListener<DishBloc, DishState>(
      listenWhen: _updateMealListenWhen,
      listener: _updateMealListener,
      child: CustomScaffold.greenLightest(
        appBar: CustomAppBar.green(
          leading: CustomFilledIconButton.leadingGreenLighter(),
          title: context.watch<DishBloc>().state.mapOrNull(
                dish: (s) => s.selectedDish.name,
              ),
          subtitle: LocalizedTexts.myDish.tr(),
        ),
        body: CustomSafeArea(
          child: BlocBuilder<DishBloc, DishState>(
            builder: (BuildContext context, state) {
              return ScrollableContainer(
                child: state.maybeMap(
                    loading: (_) => const Loader(),
                    error: (errorState) {
                      final error = errorState.fetchError;
                      return ErrorScreen(
                        error: error,
                        onButtonPressed: () {
                          final dishBloc = context.read<DishBloc>();
                          if (widget.isMealDish ?? false) {
                            dishBloc.add(DishEvent.getDishById(widget.dishId));
                          } else {
                            dishBloc.add(DishEvent.getClonedDish(widget.dishId));
                          }
                        },
                      );
                    },
                    dish: (dishState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ServingsAmount(
                                inputController: _servingController,
                                onValueChangeHandler:
                                    _onServingChanges.withDebounce(const Duration(milliseconds: 500)),
                              ),
                              NutritionValuesBlock(
                                numberOfPortions: dishState.selectedDish.numberOfServings.toInt(),
                                nutritionValuesList: dishState.selectedDish.serving.list,
                                selectedNutritionType: dishState.currentNutritionType,
                                onNutritionFactSelect: _onNutritionFactSelect,
                              ),
                              DishList(
                                list: dishState.selectedDish.foodItems,
                                nutritionKey: dishState.currentNutritionType.name,
                                onDeleteHandler: _onDeleteFoodItemPressed,
                                onListItemTapHandler: _onFoodItemPressed,
                                isScrollable: false,
                              ),
                              NutritionSummary(
                                proteinDegree: dishState.selectedDish.proteinDegreeValue,
                                calorieDensity: dishState.selectedDish.calorieDensityValue,
                                fiber: dishState.selectedDish.fiberSum * _servingsAmount,
                                carbFiberRatio: dishState.selectedDish.carbFiberRatio,
                                carbsPercent: dishState.selectedDish.carbsPercent,
                                totalCalories: dishState.selectedDish.caloriesSumWithDrinks * _servingsAmount,
                              ),
                              const SizedBox(height: 26.0),
                              MainContainer(
                                child: SizedBox(
                                  height: 35,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: CustomOutlinedButton.blueFullWidth(
                                          label: LocalizedTexts.addFoodItem.tr(),
                                          onPressed: _onAddFoodItemHandler,
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      if (widget.canEditDish)
                                        Expanded(
                                          child: CustomOutlinedButton.blueFullWidth(
                                              label: LocalizedTexts.editMyDish.tr(),
                                              onPressed: _onEditDishHandler // disable for now,
                                              ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (!(widget.isMealDish ?? false))
                            Column(
                              children: [
                                const SizedBox(height: 26.0),
                                MainContainer(
                                  child: BlocBuilder<DishBloc, DishState>(
                                    builder: (BuildContext context, state) {
                                      return state.maybeMap(
                                          dish: (dishState) {
                                            return CustomElevatedButton.blueFullWidth(
                                              onPressed: dishState.hasFoodItems ? _onLogDishHandler : null,
                                              label: LocalizedTexts.logItem.tr(),
                                            );
                                          },
                                          orElse: () => const SizedBox.shrink());
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                        ],
                      );
                    },
                    orElse: () => const SizedBox.shrink()),
              );
            },
          ),
        ),
      ),
    );
  }

  void _updateMealListener(BuildContext context, DishState state) {
    if (state.dish == null) return;

    final mealBloc = context.read<MealsBloc>();
    final mealId = mealBloc.state.getCurrentMealId;

    if (mealId == null) return;

    _servingController = TextEditingController(text: state.servingAmount);

    mealBloc.add(MealsEvent.fetchMealById(mealId));
  }

  bool _updateMealListenWhen(DishState previous, DishState current) {
    return previous.dish != current.dish && (widget.isMealDish ?? false);
  }
}
