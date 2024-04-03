import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_favorites_category/dish_favorites_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/sliver_recipe_app_bar_delegate.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/flexibile_header.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/ingredients.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/instructions.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/widgets/summary.dart';

class RecipeDetailsPage extends StatefulWidget {
  final bool fromRecommendation;

  const RecipeDetailsPage({
    super.key,
    this.fromRecommendation = false,
  });

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  static const double _defaultNumberOfUnitsForDish = 1.0;

  @override
  void initState() {
    final recipeId = context.read<RecipeBloc>().state.externalRecipeId;

    if (recipeId != null) {
      context.read<RecipeDetailsBloc>().add(
            RecipeDetailsEvent.fetchOriginRecipe(int.parse(recipeId)),
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          loading: (_) {
            return CustomScaffold.greenLightest(
              appBar: CustomAppBar.green(
                leading: CustomFilledIconButton.leadingGreenLighter(),
              ),
              body: const Loader(),
            );
          },
          recipeInfo: (s) {
            return DefaultTabController(
              length: 3,
              child: Builder(builder: (context) {
                final tabController = DefaultTabController.of(context);
                tabController.addListener(() => _logAnalytics(tabController));
                return CustomScaffold.greenLightest(
                  body: NestedScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        FlexibleHeader(innerBoxIsScrolled: false, tabController: tabController),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: SliverRecipeAppBarDelegate(
                            TabBar(
                              tabs: [
                                Tab(text: LocalizedTexts.summary.tr()),
                                Tab(text: LocalizedTexts.instructions.tr()),
                                Tab(text: LocalizedTexts.ingredients.tr()),
                              ],
                            ),
                          ),
                        ),
                        // const RecipeDetailsAppBar(),
                      ];
                    },
                    body: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: TabBarView(
                            children: [
                              Summary(
                                onAddToDishPress: () => _onSaveToMyDishesHandler(),
                                fromRecommendation: widget.fromRecommendation,
                              ),
                              const Instructions(),
                              const Ingredients(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  String get _genericDishName {
    // TODO dish name cant be empty, so get generic name for now
    final mealCategory = context.read<MealsBloc>().state.currentMealCategory;
    final mealId = context.read<MealsBloc>().state.getCurrentMealId;
    return '$mealCategory dish from meal $mealId';
  }

  void _onSaveToMyDishesHandler() {
    final state = context.read<MealsBloc>().state;

    final mealCategory =
        DishFavoritesCategory.values.asNameMap().containsKey(state.currentMealCategory?.toLowerCase())
            ? state.currentMealCategory
            : MealCategory.breakfast.originalValue;

    if (mealCategory == null) return;

    if (state.isContainsRecipeOrDish) {
      context.showError(content: Text(LocalizedTexts.invalidCreateDishFromMealMessage.tr()));
      return;
    }

    context.router.push(
      EditDishRoute(
        mode: EditDishPageMode.create,
        event: EditDishEvent.createDishFromExternalRecipe(
          int.parse(context.read<RecipeBloc>().state.externalRecipeId ?? ''),
          _defaultNumberOfUnitsForDish,
          _getSelectedMealCategories(mealCategory),
        ),
        fromRecommendation: widget.fromRecommendation,
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

  void _logAnalytics(TabController tabController) {
    switch (tabController.index) {
      case 1:
        AnalyticsEventService.instance.logEvent(FirebaseEvents.recipeDetailsScreenInstructions);
        break;
      case 2:
        AnalyticsEventService.instance.logEvent(FirebaseEvents.recipeDetailsScreenIngredients);
        break;
      default:
        AnalyticsEventService.instance.logEvent(FirebaseEvents.recipeDetailsScreenSummary);
        break;
    }
  }
}
