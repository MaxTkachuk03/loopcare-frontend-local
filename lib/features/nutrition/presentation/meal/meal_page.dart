import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/choose_date/choose_date_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_favorites_category/dish_favorites_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal/widgets/choose_date_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal/widgets/meals_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/plus_button_hexagon/plus_button_hexagon.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  static const double _defaultNumberOfUnitsForDish = 1.0;
  DateTime currentDate = DateTime.now();

  void _onSaveToMyDishesHandler() {
    final state = context.read<MealsBloc>().state;

    final mealCategory =
        DishFavoritesCategory.values.asNameMap().containsKey(state.currentMealCategory?.toLowerCase())
            ? state.currentMealCategory
            : MealCategory.breakfast.originalValue;

    final mealId = state.getCurrentMealId;

    if (mealId == null || mealCategory == null) return;

    if (state.isContainsRecipeOrDish) {
      context.showError(content: Text(LocalizedTexts.invalidCreateDishFromMealMessage.translation));
      return;
    }

    context.router.push(
      EditDishRoute(
        mode: EditDishPageMode.create,
        event: EditDishEvent.createDishFromMeal(
          mealId,
          _defaultNumberOfUnitsForDish,
          mealCategory,
          _genericDishName,
        ),
      ),
    );
  }

  String get _genericDishName {
    // TODO dish name cant be empty, so get generic name for now
    final mealCategory = context.read<MealsBloc>().state.currentMealCategory;
    final mealId = context.read<MealsBloc>().state.getCurrentMealId;
    return '$mealCategory dish from meal $mealId';
  }

  String get _appBarTitle {
    final state = context.read<MealsBloc>().state;
    final currentMealCategory = state.currentMealCategory;

    if (currentMealCategory == null) return '';

    final date = state.getCurrentDate.isoStringWithoutTime != DateTime.now().isoStringWithoutTime
        ? state.getCurrentDate.shortDate
        : 'today';

    AnalyticsEventService.instance
        .logEvent('meal_screen_type_${currentMealCategory.replaceAll(' ', '_').replaceFirst('&', 'and')}');

    return '${currentMealCategory.capitalizeOnlyFirstLetter()}${state.isPlanningMeals ? '' : ' ${LocalizedTexts.logList.translation}'} $date';
  }

  String get _appBarSubTitle {
    final state = context.read<MealsBloc>().state;
    final dates = state.currentMealDates;

    if (dates != null) {
      return dates.length > 1 ? '(and ${dates.length - 1} other dates)' : '';
    }
    return '';
  }

  String _mealDates(MealsState state, {bool needNewLine = false}) {
    final dates = state.currentMealDates;
    String newLine = needNewLine ? '\n' : '';
    if (dates != null) {
      final addString = dates.length > 1 ? '$newLine(and ${dates.length - 1} other dates)' : '';

      return '${state.getCurrentDate.shortDate} $addString';
    }
    return state.getCurrentDate.shortDate;
  }

  void _onFilledListener(BuildContext context, MealsState state) {
    if (state.currentMeal == null) {
      context.router.popUntilRouteWithName(HomeRoute.name);
    }
    context.read<ChooseDateBloc>().add(ChooseDateEvent.fetchMealById(state.getCurrentMealId ?? -1));
  }

  void _onChooseDates(BuildContext context) {
    final state = context.read<MealsBloc>().state;

    if (state.currentFoodItems.isNotEmpty) {
      context.router.push(
        ChooseDateCalendarRoute(
          mealCategory: state.currentMealCategory ?? '',
          dates: state.currentMeal?.planningDates,
          mealId: context.read<MealsBloc>().state.getCurrentMealId ?? -1,
        ),
      );
    }
  }

  void _onNutritionFactSelect(NutritionValuesTypes item) {
    context.read<MealsBloc>().add(
          MealsEvent.nutritionItemChanged(item),
        );
  }

  _onRecommendationsPressed(BuildContext context) {
    final mealState = context.read<MealsBloc>().state;
    final mealCategory = mealState.currentMealCategory;

    if (mealCategory != null) {
      context.router.push(
        RecommendationsRoute(
          mealCategory: mealCategory,
          date: mealState.getCurrentDate,
          fromMealPage: true,
        ),
      );
    }
  }

  void _setOriginDate() {
    final mealBloc = context.read<MealsBloc>();
    mealBloc.add(MealsEvent.setCurrentDate(mealBloc.state.getOriginDate));
  }

  _onDeleteMealPressed(BuildContext context) {
    final mealsState = context.read<MealsBloc>().state;
    final currentCategory = mealsState.currentMealCategory;
    final mealDates = mealsState.currentMealDates;

    if (currentCategory == null) return;

    if (mealDates != null && mealDates.length > 1) {
      ModalBottomSheet.deleteMultiDateMeal(
        context: context,
        onCanceled: () {
          context.router.pop();
          _onChooseDates(context);
        },
        onDeleted: () {
          context.read<MealsBloc>().add(
                MealsEvent.deleteMeal(
                  context.read<MealsBloc>().state.getCurrentMealId,
                ),
              );

          _setOriginDate();

          context.router.popUntilRouteWithName(HomeRoute.name);
        },
        mealCategory: currentCategory,
      );
    } else {
      ModalBottomSheet.deleteMeal(
        context: context,
        onDeleted: () {
          context.read<MealsBloc>().add(
                MealsEvent.deleteMeal(
                  context.read<MealsBloc>().state.getCurrentMealId,
                ),
              );

          _setOriginDate();

          context.router.popUntilRouteWithName(HomeRoute.name);
        },
        mealCategory: currentCategory,
      );
    }
  }

  _onBackToDashboardPressed(BuildContext context) {
    final state = context.read<MealsBloc>().state;

    if (state.currentFoodItems.isEmpty) {
      context.read<MealsBloc>().add(MealsEvent.deleteMeal(state.getCurrentMealId));
    }

    _setOriginDate();
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  Future<bool> _onWillPop(BuildContext context) async {
    _onBackToDashboardPressed(context);

    return Future.value(true);
  }

  @override
  void initState() {
    final mealState = context.read<MealsBloc>().state;
    final mealCategory = mealState.currentMealCategory;

    if (mealCategory != null) {
      context.read<RecipeBloc>().add(RecipeEvent.getRecommendations(mealCategory));
    }

    final state = context.read<MealsBloc>().state;
    currentDate = state.getCurrentDate;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealsBloc, MealsState>(
      listenWhen: (prev, cur) => cur.getCurrentMealId != null,
      listener: _onFilledListener,
      builder: (BuildContext context, state) {
        return WillPopScope(
          onWillPop: () => _onWillPop(context),
          child: Scaffold(
            appBar: BlueAppBar(
              isCustomLeading: true,
              title: _appBarTitle,
              subtitle: _appBarSubTitle,
              italicSubtitle: false,
              actions: currentDate.isTodayOrFuture ? const [PlusButtonHexagon()] : null,
            ),
            body: SafeArea(
              child: ScrollableContainer(
                child: state.maybeMap(
                  loading: (_) => const Loader(),
                  error: (errorState) {
                    final error = errorState.fetchError;

                    return ErrorScreen(
                      error: error,
                      //TODO: need to check
                      onButtonPressed: () {
                        final mealId = context.read<MealsBloc>().state.getCurrentMealId;
                        if (mealId != null) {
                          context.read<MealsBloc>().add(MealsEvent.fetchMealById(mealId));
                        }
                      },
                    );
                  },
                  mealsInfo: (mealsState) {
                    if (mealsState.isLoading) {
                      return const Loader();
                    }

                    final error = mealsState.error;

                    if (error != null) {
                      return SizedBox(
                        width: double.infinity,
                        child: MainContainer(
                          child: ErrorScreen(error: error),
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NutritionValuesBlock(
                              numberOfPortions: mealsState.currentMeal?.serving.numberOfUnits.toInt() ?? 0,
                              selectedNutritionType: mealsState.currentNutritionType,
                              nutritionValuesList: mealsState.currentMeal?.serving.list ?? <NutritionItem>[],
                              onNutritionFactSelect: _onNutritionFactSelect,
                            ),
                            MealsList(isActive: currentDate.isTodayOrFuture),
                            NutritionBlock(
                              proteinDegree: state.currentMealProteinDegree,
                              calorieDensity: state.currentMealCalorieDensity,
                            ),
                            // TODO: LOOPCARE-1798 Hide Meal planning block
                            // ChooseDateBlock(
                            //   date: _mealDates(mealsState),
                            //   onTap: (BuildContext context) =>
                            //       currentDate.isTodayOrFuture ? _onChooseDates(context) : null,
                            // ),
                            const SizedBox(height: 26.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OutlinedRoundedButton(
                                    text: LocalizedTexts.saveToMyDishes.translation,
                                    icon: AppIcons.dish,
                                    onPressed: _onSaveToMyDishesHandler,
                                  ),
                                  const SizedBox(height: 16.0),
                                  if (mealsState.isPlanningMeals && currentDate.isTodayOrFuture)
                                    BlocBuilder<RecipeBloc, RecipeState>(
                                      builder: (BuildContext context, recipeState) {
                                        return OutlinedRoundedButton(
                                          text: LocalizedTexts.recommendations.translation,
                                          icon: AppIcons.recommendations,
                                          onPressed: () => recipeState.data.recommendationRecipe.isEmpty
                                              ? null
                                              : _onRecommendationsPressed(context),
                                          active: recipeState.data.recommendationRecipe.isNotEmpty,
                                        );
                                      },
                                    ),
                                  if (mealsState.isPlanningMeals) const SizedBox(height: 16.0),
                                  OutlinedRoundedButton(
                                    text: LocalizedTexts.deleteMeal.translation,
                                    icon: AppIcons.delete,
                                    onPressed: () => _onDeleteMealPressed(context),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 26.0),
                            MainContainer(
                              child: ElevatedButton(
                                onPressed: () => _onBackToDashboardPressed(context),
                                child: Text(LocalizedTexts.backToDashboard.translation),
                              ),
                            ),
                            const SizedBox(height: 20.0)
                          ],
                        )
                      ],
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
