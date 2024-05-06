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
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/keyboard_listener_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dish_details_page/widgets/dish_list/dish_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/widgets/close_action.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/widgets/meal_category_chips.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/servings_amount/servings_amount.dart';

enum EditDishPageMode { edit, create }

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
  bool _isUserSaveChanges = false;

  final _chips = [MealCategory.breakfast, MealCategory.lunch, MealCategory.dinner];
  List<MealCategory> _selectedMealCategories = [MealCategory.breakfast];
  late final TextEditingController _servingController = TextEditingController();
  late final TextEditingController _portionsController = TextEditingController();
  late final TextEditingController _dishNameController = TextEditingController();

  final FocusNode _servingFocusNode = FocusNode();
  final FocusNode _portionsFocusNode = FocusNode();
  final FocusNode _dishNameFocusNode = FocusNode();

  @override
  void initState() {
    final editDishBloc = context.read<EditDishBloc>();
    editDishBloc.add(widget.event);

    _servingController.text = editDishBloc.state.servingAmount;

    super.initState();
  }

  @override
  void dispose() {
    _servingFocusNode.dispose();
    _portionsFocusNode.dispose();
    _dishNameFocusNode.dispose();

    _servingController.dispose();
    _dishNameController.dispose();
    _portionsController.dispose();

    super.dispose();
  }

  void _onNutritionFactSelect(NutritionValuesTypes item) {
    context.read<EditDishBloc>().add(EditDishEvent.nutritionItemChanged(item));
  }

  void _onAddFoodItemHandler() {
    FocusScope.of(context).unfocus();
    TextEditingController().clear();

    context.router.push(
      SearchRoute(
        mode: SearchMode.food,
        onItemTap: (SearchItem item) {
          context.router.push(
            SelectServingRoute(
              foodItemId: item.id,
              foodItemName: item.name,
              initialServingAmount: 1,
              onConfirm: (double numberOfUnits, String servingId) {
                context.read<EditDishBloc>().add(
                      EditDishEvent.addFoodItemToDish(
                        numberOfUnits: numberOfUnits,
                        servingId: servingId,
                        externalFoodItemId: item.id,
                      ),
                    );

                AnalyticsEventService.instance.logEvent(
                  FirebaseEvents.foodLogged,
                  parameters: {
                    CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
                    CustomDefinitions.mealId: item.id,
                    CustomDefinitions.foodItem: item.id,
                    CustomDefinitions.servingId: servingId,
                    CustomDefinitions.numberOfUnits: numberOfUnits.toString(),
                    CustomDefinitions.isDishes: 'true',
                  },
                );
                context.router.popUntilRouteWithName(SearchRoute.name);
              },
            ),
          );
        },
      ),
    );
  }

  void _onDeleteDishHandler() {
    context.read<EditDishBloc>().add(const EditDishEvent.deleteDish());
  }

  void _onServingChanges(String value) {}

  String? _validationError() {
    if (_selectedMealCategories.isEmpty) {
      return LocalizedTexts.invalidDishSelectedMealCategory.tr();
    }
    if (_dishNameController.text.isEmpty) {
      return LocalizedTexts.invalidDishNameMessage.tr();
    }
    if (_portionsController.text.isEmpty) {
      return LocalizedTexts.invalidDishPortionsAmountMessage.tr();
    }
    if (_servingController.text.isEmpty) {
      return LocalizedTexts.invalidDishServingsAmountMessage.tr();
    }
    return null;
  }

  void _onSaveDishHandler() {
    final state = context.read<EditDishBloc>();
    final error = _validationError();

    if (error != null) {
      _showValidationSnackbar(error);
      return;
    }

    state.add(EditDishEvent.updateDish(
      name: _dishNameController.text,
      numberOfUnits: double.parse(_servingController.text.replaceCommaWithDot.deleteDotAtTheEnd),
      numberOfServings: double.parse(_portionsController.text),
      mealCategories: _selectedMealCategories,
    ));

    setState(() {
      _isUserSaveChanges = true;
    });
    context.showSuccessBar(content: Text(LocalizedTexts.dishWasSaved.tr()));
    context.router.pop();
  }

  void _showValidationSnackbar(String error) => context.showError(content: Text(error));

  void _onDeleteFoodItem(BuildContext context, FoodItem item) {
    final dishId = context.read<EditDishBloc>().state.mapOrNull(dishInfo: (s) => s.currentDish.id);

    if (dishId == null) return;

    context.read<EditDishBloc>().add(EditDishEvent.deleteFoodItemFromDish(
          dishId: dishId,
          internalFoodItemId: int.parse(item.id),
        ));
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
        onConfirm: (double numberOfUnits, String servingId) {
          final dishId = context.read<EditDishBloc>().state.mapOrNull(dishInfo: (s) => s.currentDish.id);

          if (dishId == null) return;

          context.read<EditDishBloc>().add(
                EditDishEvent.updateFoodItemInDish(
                  dishId: dishId,
                  internalFoodItemId: item.id.toString(),
                  numberOfUnits: numberOfUnits,
                  servingId: servingId,
                ),
              );

          AnalyticsEventService.instance.logEvent(
            FirebaseEvents.foodLogged,
            parameters: {
              CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
              CustomDefinitions.mealId: item.id.toString(),
              CustomDefinitions.servingId: servingId,
              CustomDefinitions.numberOfUnits: numberOfUnits.toString(),
              CustomDefinitions.isDishes: 'true',
            },
          );
        },
      ),
    );
  }

  _onChipPressed(item) {
    List<MealCategory> updatedCategories = List.from(_selectedMealCategories);

    if (updatedCategories.contains(item)) {
      updatedCategories.remove(item);
    } else {
      updatedCategories.add(item);
    }

    setState(() {
      _selectedMealCategories = updatedCategories;
    });
  }

  _dishLoadedlistener(BuildContext context, state) {
    if (state is DishInfo) {
      _selectedMealCategories = state.currentDish.mealCategories;
      _dishNameController.text = state.currentDish.name;
    }
  }

  _deleteDishListener(BuildContext context, state) {
    context.router.pop();
  }

  Future<bool> _onWillPop() {
    if (widget.mode == EditDishPageMode.create && !_isUserSaveChanges) {
      _onDeleteDishHandler();
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MultiBlocListener(
        listeners: [
          BlocListener<EditDishBloc, EditDishState>(
            listener: _dishLoadedlistener,
            listenWhen: (previous, current) => previous is Loading && current is DishInfo,
          ),
          BlocListener<EditDishBloc, EditDishState>(
            listener: _deleteDishListener,
            listenWhen: (previous, current) => previous is DishInfo && current is Deleted,
          )
        ],
        child: KeyboardContainerListener(
          child: CustomScaffold.greenLightest(
            appBar: CustomAppBar.green(
              title: '${LocalizedTexts.addToMyDishedAs.tr()}...',
              leading: CustomFilledIconButton.leadingGreenLighter(),
              actions: const [CloseAction(), SizedBox(width: 16.0)],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(150),
                child: Column(
                  children: [
                    BlocBuilder<MealsBloc, MealsState>(
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          color: state.isPlanningMeals ? AppColors.darkGreen : AppColors.greenRegular,
                          child: BlocBuilder<EditDishBloc, EditDishState>(
                            builder: (BuildContext context, state) {
                              return state.maybeMap(
                                dishInfo: (dishState) {
                                  return MealCategoryChips(
                                    categories: _chips,
                                    selectedChips: _selectedMealCategories.first,
                                    onItemPressHandler: _onChipPressed,
                                  );
                                },
                                orElse: () => const SizedBox.shrink(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    BlocBuilder<MealsBloc, MealsState>(
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.all(20.0),
                          color: state.isPlanningMeals ? AppColors.darkGreen : AppColors.greenRegular,
                          child: CustomTextField(
                            focusNode: _dishNameFocusNode,
                            controller: _dishNameController,
                            hintText: LocalizedTexts.giveNameToThisDish.tr(),
                          ),
                        );
                      },
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
                        loading: (_) => const Loader(),
                        orElse: () => const SizedBox.shrink(),
                        error: (errorState) {
                          final error = errorState.fetchError;

                          return ErrorScreen(
                            error: error,
                            onButtonPressed: () {
                              //TODO: Need to check
                              final editDishBloc = context.read<EditDishBloc>();
                              editDishBloc.add(widget.event);
                            },
                          );
                        },
                        dishInfo: (dishState) {
                          _servingController.text = dishState.numberOfServings;
                          _portionsController.text = dishState.numberOfPortions;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  ServingsAmount(
                                    focusNode: _servingFocusNode,
                                    inputController: _servingController,
                                    onValueChangeHandler: _onServingChanges,
                                  ),
                                  NutritionValuesBlock(
                                    portionsFocusNode: _portionsFocusNode,
                                    portionsController: _portionsController,
                                    isPortionsEditable: true,
                                    numberOfPortions: dishState.currentDish.numberOfServings.toInt(),
                                    nutritionValuesList: dishState.currentDish.serving.list,
                                    selectedNutritionType: dishState.currentNutritionType,
                                    onNutritionFactSelect: _onNutritionFactSelect,
                                  ),
                                  DishList(
                                    list: dishState.currentDish.foodItems,
                                    nutritionKey: dishState.currentNutritionType.name,
                                    onDeleteHandler: _onDeleteFoodItem,
                                    onListItemTapHandler: _onTapFoodItem,
                                    isScrollable: false,
                                  ),
                                  NutritionSummary(
                                    proteinDegree: dishState.currentDish.proteinDegreeValue,
                                    calorieDensity: dishState.currentDish.calorieDensityValue,
                                    fiber: dishState.currentDish.fiberSum,
                                    carbFiberRatio: dishState.currentDish.carbFiberRatio,
                                    carbsPercent: dishState.currentDish.carbsPercent,
                                    totalCalories: dishState.currentDish.caloriesSum,
                                  ),
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
                                            onPressed: _onDeleteDishHandler,
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                ],
                              ),
                              Column(
                                children: [
                                  MainContainer(
                                    child: BlocBuilder<EditDishBloc, EditDishState>(
                                      builder: (BuildContext context, state) {
                                        return state.maybeMap(
                                            dishInfo: (dishState) {
                                              return CustomElevatedButton.blueFullWidth(
                                                onPressed: dishState.hasFoodItems ? _onSaveDishHandler : null,
                                                label: LocalizedTexts.save.tr(),
                                              );
                                            },
                                            orElse: () => const SizedBox.shrink());
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30.0),
                                ],
                              ),
                            ],
                          );
                        });
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
