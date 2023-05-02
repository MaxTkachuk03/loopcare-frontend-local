import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
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

  @override
  void initState() {
    if (widget.isMealRecipe ?? false) {
      final mealId = context.read<MealsBloc>().state.getCurrentMealId;

      if (mealId == null) return;

      context.read<RecipeBloc>().add(RecipeEvent.fetchRecipeFromMeal(
            recipeId: widget.id,
            mealId: mealId,
          ));
    } else {
      context.read<RecipeBloc>().add(RecipeEvent.fetchRecipe(widget.id));
    }

    super.initState();
  }

  @override
  void dispose() {
    _servingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RecipeBloc, RecipeState>(
          listener: _recipeListener,
          listenWhen: (previous, current) =>
              previous is Loading && current is RecipeInfo,
        ),
        BlocListener<RecipeBloc, RecipeState>(
          listenWhen: _whenRecipeUpdated,
          listener: _recipeUpdatingListener,
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
                            nutritionValue: recipeState.currentRecipeNutritionItem.value,
                            onNutritionFactSelect: _onNutritionFactSelect),
                        RecipeList(
                          nutritionKey:
                              recipeState.currentRecipeNutritionItem.key,
                          list: recipeState.recipe.ingredients,
                        ),
                        const NutritionBlock(),
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
                                    text:
                                        LocalizedTexts.addFoodItem.translation,
                                    icon: AppIcons.plus,
                                    onPressed: () {},
                                  ),
                                  OutlinedRoundedButton(
                                    text: LocalizedTexts
                                        .saveToMyDishes.translation,
                                    icon: AppIcons.dish,
                                    onPressed: () {},
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              OutlinedRoundedButton(
                                text: LocalizedTexts.viewRecipe.translation,
                                icon: AppIcons.chef,
                                onPressed: () {},
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                            ],
                          ),
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
    );
  }

  void _onValueChangeHandler(String val) {
    final mealId = context.read<MealsBloc>().state.getCurrentMealId;
    if (mealId == null || val.isEmpty) return;

    context.read<RecipeBloc>().add(RecipeEvent.servingChanged(
          mealId: mealId,
          servingAmount: int.parse(val),
        ));
  }

  void _recipeListener(BuildContext context, RecipeState state) {
    final recipeState = state.mapOrNull(recipeInfo: (s) => s.recipe);

    if (recipeState == null) return;

    _servingController = TextEditingController(text: "1");

    context.read<NutritionInstructionsBloc>()
      ..add(NutritionInstructionsEvent.setProteinDegree(
          recipeState.proteinDegree))
      ..add(NutritionInstructionsEvent.setCalorieDensity(
          recipeState.calorieDensity));
  }

  void _recipeUpdatingListener(BuildContext context, RecipeState state) {
    context.read<MealsBloc>().add(const MealsEvent.fetchMeals());
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
}
