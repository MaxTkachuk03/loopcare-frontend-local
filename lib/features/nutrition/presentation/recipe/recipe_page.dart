import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
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
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_favorites_category/dish_favorites_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe/widgets/recipe_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/servings_amount/servings_amount.dart';

class RecipePage extends StatefulWidget {
  final bool? isMealRecipe;
  final int id;
  final String name;

  const RecipePage({
    super.key,
    required this.id,
    required this.name,
    this.isMealRecipe,
  });

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late TextEditingController _servingController;
  bool _isLogRecipePressed = false;
  int? internalRecipeId;

  @override
  void initState() {
    final recipeBloc = context.read<RecipeBloc>();

    _servingController = TextEditingController(text: recipeBloc.state.servingAmount);

    if (widget.isMealRecipe ?? false) {
      final mealId = context.read<MealsBloc>().state.data.getCurrentMealId;

      if (mealId == null) return;

      recipeBloc.add(RecipeEvent.fetchRecipeFromMeal(
        recipeId: widget.id,
        mealId: mealId,
      ));
    } else {
      recipeBloc.add(RecipeEvent.fetchRecipe(widget.id));
    }

    super.initState();
  }

  @override
  void dispose() {
    _servingController.dispose();

    super.dispose();
  }

  get _currentRecipeId {
    final recipeState = context.read<RecipeBloc>().state;
    final mealState = context.read<MealsBloc>().state;
    final isMealRecipe = widget.isMealRecipe ?? false;

    final recipeId = !isMealRecipe
        ? mealState.data.currentFoodItems
            .firstWhere((element) =>
                element.type == MealItemType.recipe && element.externalId == recipeState.externalRecipeId)
            .id
        : recipeState.recipeId;

    return recipeId;
  }

  void _onSaveToMyDishesHandler() {
    final recipeState = context.read<RecipeBloc>().state;
    final numberOfUnits = recipeState.numberOfUnits;
    final mealState = context.read<MealsBloc>().state;

    final recipeId = _currentRecipeId;

    if (recipeId == null || numberOfUnits == null) return;

    context.router.push(
      EditDishRoute(
        mode: EditDishPageMode.create,
        event: EditDishEvent.createDishFromRecipe(
          recipeId,
          numberOfUnits,
          _getSelectedMealCategories(mealState.data.currentMealCategory),
        ),
      ),
    );
  }

  List<DishFavoritesCategory> _getSelectedMealCategories(String? category) {
    List<DishFavoritesCategory> defaultMealCategories = [];
    if (category == null) return defaultMealCategories;

    for (final mealCategory in DishFavoritesCategory.values) {
      if (mealCategory.value == category) {
        defaultMealCategories.add(mealCategory);
      }
    }

    if (defaultMealCategories.isEmpty) {
      defaultMealCategories.add(DishFavoritesCategory.breakfast);
    }

    return defaultMealCategories;
  }

  @override
  Widget build(BuildContext context) {
    final isMealRecipe = widget.isMealRecipe ?? false;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: MultiBlocListener(
        listeners: [
          BlocListener<RecipeBloc, RecipeState>(
            listener: _recipeListener,
            listenWhen: (previous, current) => previous is LoadingRecipe && current is RecipeInfo,
          ),
          BlocListener<RecipeBloc, RecipeState>(
            listenWhen: _whenRecipeUpdated,
            listener: _recipeUpdatingListener,
          ),
        ],
        child: CustomScaffold.greenLighter(
          appBar: CustomAppBar.green(
            leading: CustomFilledIconButton.leadingGreenLighter(),
            title: widget.name,
            subtitle: LocalizedTexts.recipe.tr(),
            actions: const [
              SizedBox(
                width: 44,
              )
            ],
          ),
          body: CustomSafeArea(
            child: ScrollableContainer(
              child: BlocBuilder<RecipeBloc, RecipeState>(
                builder: (BuildContext context, state) {
                  return state.maybeMap(
                    loadingRecipe: (_) => const Loader(),
                    error: (errorState) {
                      final error = errorState.data.error;

                      return ErrorScreen(
                        error: error!,
                        //TODO: need to check
                        onButtonPressed: () =>
                            context.read<RecipeBloc>().add(RecipeEvent.fetchRecipe(_currentRecipeId)),
                      );
                    },
                    recipeInfo: (recipeState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ServingsAmount(
                                inputController: _servingController,
                                onValueChangeHandler:
                                    _onValueChangeHandler.withDebounce(const Duration(milliseconds: 500)),
                              ),
                              NutritionValuesBlock(
                                numberOfPortions: recipeState.data.recipe.numberOfServings,
                                selectedNutritionType: recipeState.data.currentNutritionType,
                                nutritionValuesList: recipeState.data.recipe.nutritionValues,
                                onNutritionFactSelect: _onNutritionFactSelect,
                              ),
                              RecipeList(
                                nutritionKey: recipeState.data.currentNutritionType.name,
                                list: recipeState.data.recipe.ingredients,
                                isMealRecipe: widget.isMealRecipe ?? false,
                              ),
                              const SizedBox(height: 20),
                              NutritionSummary(
                                proteinDegree: recipeState.data.recipe.proteinDegreeVal,
                                calorieDensity: recipeState.data.recipe.calorieDensityVal,
                                fiber: recipeState.data.recipe.fiberSum,
                                carbFiberRatio: recipeState.data.recipe.carbFiberRatio,
                                carbsPercent: recipeState.data.recipe.carbsPercent,
                                totalCarbs: recipeState.data.recipe.totalCarbs,
                                totalCalories: recipeState.data.recipe.totalCalories,
                              ),
                              const SizedBox(height: 15.0),
                              MainContainer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: CustomOutlinedButton.blueSmall(
                                            label: LocalizedTexts.addToDishes.tr(),
                                            onPressed: _onSaveToMyDishesHandler,
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: CustomOutlinedButton.blueSmall(
                                            label: LocalizedTexts.addFoodItem.tr(),
                                            onPressed: _addFoodItemPressed,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 10.0),
                                            child: CustomOutlinedButton.blueSmall(
                                              label: LocalizedTexts.viewRecipe.tr(),
                                              onPressed: _onViewRecipePressed,
                                            ),
                                          ),
                                        ),
                                        const Expanded(child: SizedBox(height: 10.0)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (!isMealRecipe)
                            MainContainer(
                              child: Column(
                                children: [
                                  const SizedBox(height: 26.0),
                                  CustomElevatedButton.blueFullWidth(
                                    onPressed: _onLogRecipePressed,
                                    label: LocalizedTexts.logItem.tr(),
                                  ),
                                  const SizedBox(height: 20.0),
                                ],
                              ),
                            )
                        ],
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onValueChangeHandler(String val) {
    final mealState = context.read<MealsBloc>().state;
    final mealId = mealState.data.getCurrentMealId;

    final recipeId = _currentRecipeId;

    if (mealId == null || val.isEmpty || recipeId == null || val == '0' || val == '0.' || val == '0.0') {
      return;
    }
    if (double.parse(val) == 0 || double.parse(val) < 0.1) return;

    context.read<RecipeBloc>().add(
        RecipeEvent.servingChanged(mealId: mealId, servingAmount: double.parse(val), recipeId: recipeId));
  }

  void _recipeListener(BuildContext context, RecipeState state) {
    final recipe = state.mapOrNull(recipeInfo: (s) => s.data.recipe);

    if (recipe == null || _isLogRecipePressed) return;
    final mealId = context.read<MealsBloc>().state.data.getCurrentMealId;

    final isMealRecipe = widget.isMealRecipe ?? false;

    if (mealId != null && !isMealRecipe) {
      context.read<MealsBloc>().add(
            MealsEvent.addRecipeToMeal(
              mealId,
              widget.id,
            ),
          );
    }

    _servingController = TextEditingController(text: state.servingAmount);
  }

  void _recipeUpdatingListener(BuildContext context, RecipeState state) {
    final mealId = context.read<MealsBloc>().state.data.getCurrentMealId;

    if (mealId != null) {
      context.read<MealsBloc>().add(MealsEvent.fetchMealById(mealId));
    }
  }

  bool _whenRecipeUpdated(
    RecipeState previous,
    RecipeState current,
  ) {
    return previous is RecipeInfo && current is RecipeInfo && current.data.recipe != previous.data.recipe;
  }

  void _onNutritionFactSelect(NutritionValuesTypes item) {
    context.read<RecipeBloc>().add(RecipeEvent.nutritionItemChanged(item));
  }

  void _onViewRecipePressed() {
    context.router.pushNamed(AppRoutes.recipeDetails);
  }

  void _onLogRecipePressed() {
    setState(() {
      _isLogRecipePressed = true;
    });
    context.router.replaceNamed(AppRoutes.meal);
  }

  Future<bool> _onWillPop() {
    final isMealRecipe = widget.isMealRecipe ?? false;

    if (!isMealRecipe && !_isLogRecipePressed && internalRecipeId != null) {
      context.read<MealsBloc>().add(MealsEvent.deleteRecipeFromMeal(internalRecipeId.toString()));
    }

    return Future.value(true);
  }

  void _addFoodItemPressed() {
    context.router.push(
      SearchRoute(
        mode: SearchMode.food,
        onItemTap: (SearchItem item) {
          final mealState = context.read<MealsBloc>().state;
          final recipeState = context.read<RecipeBloc>().state;
          final mealId = mealState.data.getCurrentMealId;
          final isMealRecipe = widget.isMealRecipe ?? false;

          final recipeId = !isMealRecipe
              ? mealState.data.currentFoodItems
                  .firstWhere((element) =>
                      element.type == MealItemType.recipe &&
                      element.externalId == recipeState.externalRecipeId)
                  .id
              : recipeState.recipeId;

          if (mealId == null || recipeId == null) {
            debugPrint('Search item click freezed RecipePage mealId == null || recipeId == null');
            return;
          }

          context.router.push(
            SelectServingRoute(
              foodItemId: item.id,
              foodItemName: item.name,
              initialServingAmount: 1,
              onConfirm: (double numberOfUnits, String servingId) {
                context.read<RecipeBloc>().add(
                      RecipeEvent.addFoodItemToRecipe(
                        mealId: mealId,
                        numberOfUnits: numberOfUnits,
                        servingId: servingId,
                        foodItemId: item.id,
                        recipeId: recipeId,
                      ),
                    );

                AnalyticsEventService.instance.logEvent(
                  FirebaseEvents.foodLogged,
                  parameters: {
                    CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
                    CustomDefinitions.mealId: mealId.toString(),
                    CustomDefinitions.foodItem: item.id,
                    CustomDefinitions.servingId: servingId,
                    CustomDefinitions.numberOfUnits: numberOfUnits.toString(),
                    CustomDefinitions.isRecipe: 'true',
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
