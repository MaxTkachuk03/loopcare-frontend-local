import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe/widgets/recipe_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/servings_amount/servings_amount.dart';

class RecipePage extends StatefulWidget {
  final bool? isMealRecipe;
  final int id;
  final String name;

  const RecipePage({
    Key? key,
    required this.id,
    required this.name,
    this.isMealRecipe,
  }) : super(key: key);

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

    _servingController =
        TextEditingController(text: recipeBloc.state.servingAmount);

    if (widget.isMealRecipe ?? false) {
      final mealId = context.read<MealsBloc>().state.getCurrentMealId;

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
        ? mealState.currentFoodItems
            .firstWhere((element) =>
                element.type == 'recipe' &&
                element.externalId == recipeState.externalRecipeId)
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

    context.router.push(EditDishRoute(
        event: EditDishEvent.createDishFromRecipe(
      recipeId,
      numberOfUnits,
      _getSelectedMealCategories(mealState.currentMealCategory),
    )));
  }

  List<MealCategory> _getSelectedMealCategories(String? category) {
    List<MealCategory> defaultMealCategories = [];
    if (category == null) return defaultMealCategories;

    for (final mealCategory in MealCategory.values) {
      if (mealCategory.name == category) {
        defaultMealCategories.add(mealCategory);
      }
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
            listenWhen: (previous, current) => current is RecipeInfo,
          ),
          BlocListener<RecipeBloc, RecipeState>(
            listenWhen: _whenRecipeUpdated,
            listener: _recipeUpdatingListener,
          ),
          BlocListener<MealsBloc, MealsState>(
            listenWhen: _whenMealsUpdated,
            listener: _mealsUpdatingListener,
          )
        ],
        child: Scaffold(
          appBar: BlueAppBar(
            isCustomLeading: true,
            title: widget.name,
            subtitle: LocalizedTexts.recipe.translation,
          ),
          body: SafeArea(
            child: ScrollableContainer(
              child: BlocBuilder<RecipeBloc, RecipeState>(
                builder: (BuildContext context, state) {
                  return state.maybeMap(
                    loading: (_) => const Loader(),
                    recipeInfo: (recipeState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ServingsAmount(
                                inputController: _servingController,
                                onValueChangeHandler: _onValueChangeHandler,
                              ),
                              NutritionValuesBlock(
                                  numberOfPortions:
                                      recipeState.recipe.numberOfServings,
                                  selectedNutritionItem:
                                      recipeState.currentRecipeNutritionItem,
                                  nutritionValuesList:
                                      recipeState.recipe.nutritionValues,
                                  nutritionValue: recipeState
                                      .currentRecipeNutritionItem.value,
                                  onNutritionFactSelect:
                                      _onNutritionFactSelect),
                              RecipeList(
                                  nutritionKey: recipeState
                                      .currentRecipeNutritionItem.key,
                                  list: recipeState.recipe.ingredients,
                                  isMealRecipe: widget.isMealRecipe ?? false),
                              NutritionBlock(
                                proteinDegree: recipeState.recipe.proteinDegree,
                                calorieDensity:
                                    recipeState.recipe.calorieDensity,
                              ),
                              const SizedBox(
                                height: 26.0,
                              ),
                              MainContainer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        OutlinedRoundedButton(
                                          text: LocalizedTexts
                                              .addFoodItem.translation,
                                          icon: AppIcons.plus,
                                          onPressed: _addFoodItemPressed,
                                        ),
                                        OutlinedRoundedButton(
                                          text: LocalizedTexts
                                              .saveToMyDishes.translation,
                                          icon: AppIcons.dish,
                                          onPressed: _onSaveToMyDishesHandler,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    OutlinedRoundedButton(
                                      text:
                                          LocalizedTexts.viewRecipe.translation,
                                      icon: AppIcons.chef,
                                      onPressed: _onViewRecipePressed,
                                    ),
                                    const SizedBox(
                                      height: 24.0,
                                    ),
                                  ],
                                ),
                              ),
                              if (!isMealRecipe)
                                MainContainer(
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: _onLogRecipePressed,
                                        child: Text(
                                          LocalizedTexts.logItem.translation,
                                        ),
                                      ),
                                      const SizedBox(height: 30.0),
                                    ],
                                  ),
                                ),
                            ],
                          ),
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
    final mealId = mealState.getCurrentMealId;

    final recipeId = _currentRecipeId;

    if (mealId == null || val.isEmpty || recipeId == null) return;

    context.read<RecipeBloc>().add(RecipeEvent.servingChanged(
          mealId: mealId,
          servingAmount: int.parse(val),
          recipeId: recipeId,
        ));
  }

  void _recipeListener(BuildContext context, RecipeState state) {
    final recipe = state.mapOrNull(recipeInfo: (s) => s.recipe);

    if (recipe == null) return;
    final mealId = context.read<MealsBloc>().state.getCurrentMealId;

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
    final mealId = context.read<MealsBloc>().state.getCurrentMealId;

    if (mealId != null) {
      context.read<MealsBloc>().add(MealsEvent.fetchMealById(mealId));
    }
  }

  bool _whenRecipeUpdated(
    RecipeState previous,
    RecipeState current,
  ) {
    return previous is RecipeInfo &&
        current is RecipeInfo &&
        current.recipe != previous.recipe;
  }

  void _onNutritionFactSelect(NutritionItem item) {
    context.read<RecipeBloc>().add(RecipeEvent.nutritionItemChanged(item));
  }

  void _onViewRecipePressed() {
    context.router.pushNamed(AppRoutes.recipeDetails);
  }

  void _onLogRecipePressed() {
    setState(() {
      _isLogRecipePressed = true;
    });
    context.router.pushNamed(AppRoutes.meal);
  }

  Future<bool> _onWillPop() {
    final isMealRecipe = widget.isMealRecipe ?? false;

    if (!isMealRecipe && !_isLogRecipePressed && internalRecipeId != null) {
      context
          .read<MealsBloc>()
          .add(MealsEvent.deleteRecipeFromMeal(internalRecipeId.toString()));
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
          final mealId = mealState.getCurrentMealId;
          final isMealRecipe = widget.isMealRecipe ?? false;

          final recipeId = !isMealRecipe
              ? mealState.currentFoodItems
                  .firstWhere((element) =>
                      element.type == 'recipe' &&
                      element.externalId == recipeState.externalRecipeId)
                  .id
              : recipeState.recipeId;

          if (mealId == null || recipeId == null) return;

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
              },
            ),
          );
        },
      ),
    );
  }

  bool _whenMealsUpdated(MealsState previous, MealsState current) {
    final externalRecipeId = context.read<RecipeBloc>().state.externalRecipeId;
    final prevFoodItems = previous.currentFoodItems;
    final curFoodItems = current.currentFoodItems;
    final newRecipeId =
        curFoodItems.firstWhere((element) => !prevFoodItems.contains(element));
    if (newRecipeId.type == 'recipe' &&
        newRecipeId.externalId == externalRecipeId) {
      setState(() {
        internalRecipeId = newRecipeId.id;
      });
    }
    return true;
  }

  void _mealsUpdatingListener(BuildContext context, MealsState state) {}
}
