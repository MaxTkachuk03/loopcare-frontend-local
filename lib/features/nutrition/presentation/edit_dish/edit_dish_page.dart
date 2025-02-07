import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_summary/nutrition_summary.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/keyboard_listener_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dish_details_page/widgets/dish_list/dish_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_controller.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/widgets/close_action.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/widgets/meal_category_chips.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/servings_amount/servings_amount.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

import '../../application/meals/meals_bloc.dart';
import '../../domain/dish/dish.dart';

enum EditDishPageMode { edit, create }

@RoutePage()
class EditDishPage extends StatefulWidget {
  final EditDishPageMode mode;
  final EditDishEvent event;
  final bool fromRecommendation;

  const EditDishPage({
    super.key,
    required this.mode,
    required this.event,
    this.fromRecommendation = false,
  });

  @override
  State<EditDishPage> createState() => _EditDishPageState();
}

class _EditDishPageState extends State<EditDishPage> {
  late final EditDishController _controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = EditDishController(
      mode: widget.mode,
      editDishBloc: context.read<EditDishBloc>(),
      retryEvent: widget.event,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onAddFoodItemHandler() {
    FocusScope.of(context).unfocus();

    context.router.push(
      SearchRoute(
        mode: SearchMode.food,
        onItemTap: (item) {
          context.router.push(
            SelectServingRoute(
              foodItemId: item.id,
              foodItemName: item.name,
              initialServingAmount: 1,
              onConfirm: (numberOfUnits, servingId) =>
                  _onConfirmSelectServing(item, numberOfUnits, servingId),
            ),
          );
        },
      ),
    );
  }

  void _onTapFoodItem(BuildContext context, DishFoodItem item) {
    final servingId = item.serving.servingId;

    if (servingId == null) return;

    context.router.push(
      SelectServingRoute(
        foodItemId: item.externalId,
        initialServingId: servingId,
        initialServingAmount: item.serving.numberOfUnits,
        initialCaloriesValue: item.serving.calories,
        foodItemName: item.foodName,
        onConfirm: (numberOfUnits, servingId) =>
            _controller.updateFoodItemInDish(item, numberOfUnits, servingId),
      ),
    );
  }

  void _onConfirmSelectServing(SearchItem item, double numberOfUnits, String servingId) {
    _controller.addFoodItemToDish(numberOfUnits, servingId, item.id);
    context.router.popUntilRouteWithName(SearchRoute.name);
  }

  Future<void> _onSaveDishHandler(Dish currentDish) async {
    final error = _controller.validate();

    if (error != null) {
      _showValidationSnackbar(error);
      return;
    }

    setState(() {
      isLoading = true;
    });

    final mealsBloc = context.read<MealsBloc>();
    final mealId = mealsBloc.state.data.getCurrentMealId;
    final dishId = currentDish.id;

    await _deleteItemsInLog(currentDish.foodItems);

    _controller.saveDish();

    mealsBloc
        .add(MealsEvent.addDishToMeal(mealId!, currentDish.numberOfServings.toString(), dishId));

    if (mounted) {
      context.showSuccessBar(content: CustomText(LocalizedTexts.dishWasSaved.tr()));

      context.router.maybePop();
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _deleteItemsInLog(List<DishFoodItem> items) async {
    final mealBloc = context.read<MealsBloc>();
    final completer = Completer<void>();

    final foodItemIdsToDelete = mealBloc.state.data.meals.values
        .expand((mealList) => mealList)
        .expand((meal) => meal.mealItems)
        .where((foodItem) => items.any((i) => i.externalId == foodItem.externalId))
        .map((foodItem) => foodItem.id.toString())
        .toList();

    if (foodItemIdsToDelete.isEmpty) {
      completer.complete();
      return completer.future;
    }

    StreamSubscription? subscription;

    subscription = mealBloc.stream.listen((state) {
      if (state is MealsStateLoaded && !state.data.isLoading) {
        subscription?.cancel();
        completer.complete();
      }
    });

    mealBloc.add(MealsEvent.deleteFoodItemFromMeal(foodItemIdsToDelete));

    return completer.future;
  }

  void _showValidationSnackbar(String error) => context.showError(content: CustomText(error));

  Future<void> _onWillPop(bool e) async => _controller.onPop();

  void _onDeleteFoodItem(BuildContext context, FoodItem item) => _controller.deleteFoodItem(item);

  void _onChangeHandler(MealCategory item) => _controller.selectedMealCategory.value = item;

  void _dishLoadedListener(BuildContext context, EditDishState state) =>
      _controller.updateFields(state.data);

  void _deleteDishListener(BuildContext context, EditDishState state) => context.router.maybePop();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (e, _) => _onWillPop,
      child: MultiBlocListener(
        listeners: [
          BlocListener<EditDishBloc, EditDishState>(
            listener: _dishLoadedListener,
            listenWhen: (previous, current) => previous is Loading && current is DishInfo,
          ),
          BlocListener<EditDishBloc, EditDishState>(
            listener: _deleteDishListener,
            listenWhen: (previous, current) => previous is DishInfo && current is Deleted,
          )
        ],
        child: KeyboardContainerListener(
          child: CustomScaffold.greenLighter(
            appBar: CustomAppBar.green(
              title: '${LocalizedTexts.addToMyDishedAs.tr()}...',
              leading: CustomFilledIconButton.leadingGreenLighter(),
              actions: const [CloseAction(), SizedBox(width: 16.0)],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(150),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      color: AppColors.greenRegular,
                      child: ValueListenableBuilder<MealCategory>(
                          valueListenable: _controller.selectedMealCategory,
                          builder: (context, category, _) {
                            return MealCategoryChips(
                              initialCategory: category,
                              onItemPressHandler: _onChangeHandler,
                            );
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      color: AppColors.greenRegular,
                      child: CustomTextField(
                        focusNode: _controller.dishNameFocusNode,
                        controller: _controller.dishNameController,
                        hintText: LocalizedTexts.giveNameToThisDish.tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: CustomSafeArea(
              child: ScrollableContainer(
                child: BlocBuilder<EditDishBloc, EditDishState>(
                  builder: (BuildContext context, state) {
                    return state.maybeMap(
                      orElse: () => const SizedBox.shrink(),
                      loading: (_) => const Loader(),
                      error: (state) => ErrorScreen(
                        error: state.data.error!,
                        onButtonPressed: _controller.retry,
                      ),
                      dishInfo: (dishState) {
                        final currentDish = dishState.data.currentDish!;
                        final currentNutritionType = dishState.data.currentNutritionType;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ServingsAmount(
                                  isReadOnly: true,
                                  inputController: _controller.servingController,
                                  onValueChangeHandler: (_) {},
                                ),
                                NutritionValuesBlock(
                                  portionsFocusNode: _controller.portionsFocusNode,
                                  portionsController: _controller.portionsController,
                                  isPortionsEditable: true,
                                  numberOfPortions: currentDish.numberOfServings.toInt(),
                                  nutritionValuesList: currentDish.serving.list,
                                  selectedNutritionType: currentNutritionType,
                                  onNutritionFactSelect: _controller.nutritionFactSelect,
                                ),
                                DishList(
                                  list: currentDish.foodItems,
                                  nutritionKey: currentNutritionType.name,
                                  onDeleteHandler: _onDeleteFoodItem,
                                  onListItemTapHandler: _onTapFoodItem,
                                  isScrollable: false,
                                ),
                                const SizedBox(height: 20),
                                ValueListenableBuilder<double>(
                                    valueListenable: _controller.servingsAmount,
                                    builder: (context, amount, _) {
                                      return NutritionSummary(
                                        proteinDegree: currentDish.proteinDegreeValue,
                                        calorieDensity: currentDish.calorieDensityValue,
                                        fiber: currentDish.fiberSum * amount,
                                        carbFiberRatio: currentDish.carbFiberRatio,
                                        carbsPercent: currentDish.carbsPercent,
                                        totalCalories: currentDish.caloriesSumWithDrinks * amount,
                                        totalCarbs: currentDish.carbsSum * amount,
                                      );
                                    }),
                                const SizedBox(height: 15.0),
                                MainContainer(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomOutlinedButton.blueSmall(
                                        label: LocalizedTexts.addFoodItem.tr(),
                                        onPressed: _onAddFoodItemHandler,
                                      ),
                                      if (widget.mode == EditDishPageMode.edit)
                                        CustomOutlinedButton.blueSmall(
                                          label: LocalizedTexts.deleteDish.tr(),
                                          onPressed: _controller.deleteDish,
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: MainContainer(
                                child: dishState.maybeMap(
                                  dishInfo: (state) => CustomElevatedButton.blueFullWidth(
                                    onPressed: state.data.hasFoodItems && !isLoading
                                        ? () => _onSaveDishHandler(currentDish)
                                        : null,
                                    label: LocalizedTexts.save.tr(),
                                    isLoading: isLoading,
                                  ),
                                  orElse: () => const SizedBox.shrink(),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
