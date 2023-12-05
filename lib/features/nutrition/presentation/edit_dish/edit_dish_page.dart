import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
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
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/widgets/meal_category_chips.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';
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
  List<MealCategory> _selectedMealCategories = [];
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
      return LocalizedTexts.invalidDishSelectedMealCategory.translation;
    }
    if (_dishNameController.text.isEmpty) {
      return LocalizedTexts.invalidDishNameMessage.translation;
    }
    if (_portionsController.text.isEmpty) {
      return LocalizedTexts.invalidDishPortionsAmountMessage.translation;
    }
    if (_servingController.text.isEmpty) {
      return LocalizedTexts.invalidDishServingsAmountMessage.translation;
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
    context.showSuccessBar(content: Text(LocalizedTexts.dishWasSaved.translation));
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
    widget.fromRecommendation ? context.router.pop() : context.router.popUntilRouteWithName(SelectFoodRoute.name);
  }

  Future<bool> _onWillPop() {
    if (widget.mode == EditDishPageMode.create && !_isUserSaveChanges) {
      _onDeleteDishHandler();
    }

    return Future.value(true);
  }

  _unfocusAllTextFields() {
    _dishNameFocusNode.unfocus();
    _servingFocusNode.unfocus();
    _portionsFocusNode.unfocus();
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
        child: GestureDetector(
          onTap: _unfocusAllTextFields,
          child: Scaffold(
            appBar: BlueAppBar(
              isCustomLeading: true,
              title: '${LocalizedTexts.addToMyDishedAs.translation}:',
            ),
            body: SafeArea(
              child: Column(
                children: [
                  BlocBuilder<MealsBloc, MealsState>(
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        color: state.isPlanningMeals ? AppColors.darkGreen : AppColors.blueAppBar,
                        child: BlocBuilder<EditDishBloc, EditDishState>(
                          builder: (BuildContext context, state) {
                            return state.maybeMap(
                              dishInfo: (dishState) {
                                return MealCategoryChips(
                                  data: _chips,
                                  selectedChips: _selectedMealCategories,
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
                        padding: const EdgeInsets.all(24.0),
                        color: state.isPlanningMeals ? AppColors.darkGreen : AppColors.blueAppBar,
                        child: TextField(
                          focusNode: _dishNameFocusNode,
                          controller: _dishNameController,
                          decoration: InputDecoration(
                            hintText: LocalizedTexts.giveNameToThisDish.translation,
                            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.greyLabel,
                                ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<EditDishBloc, EditDishState>(
                    builder: (BuildContext context, state) {
                      return state.maybeMap(
                          loading: (_) => const Expanded(child: Loader()),
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

                            return Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ScrollableContainer(
                                            child: Column(
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
                                                NutritionBlock(
                                                  calorieDensity: dishState.currentDish.calorieDensity,
                                                  proteinDegree: dishState.currentDish.proteinDegree,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
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
                                              onPressed: _onAddFoodItemHandler,
                                            ),
                                            const SizedBox(width: 16.0),
                                            if (widget.mode == EditDishPageMode.edit)
                                              OutlinedRoundedButton(
                                                text: LocalizedTexts.deleteDish.translation,
                                                icon: AppIcons.delete,
                                                onPressed: _onDeleteDishHandler,
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  MainContainer(
                                    child: Column(
                                      children: [
                                        BlocBuilder<EditDishBloc, EditDishState>(
                                          builder: (BuildContext context, state) {
                                            return state.maybeMap(
                                                dishInfo: (dishState) {
                                                  return ElevatedButton(
                                                    onPressed: dishState.hasFoodItems ? _onSaveDishHandler : null,
                                                    child: Text(
                                                      LocalizedTexts.save.translation,
                                                    ),
                                                  );
                                                },
                                                orElse: () => const SizedBox.shrink());
                                          },
                                        ),
                                        const SizedBox(height: 30.0),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          orElse: () => const SizedBox.shrink());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
