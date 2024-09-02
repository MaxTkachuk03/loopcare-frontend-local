import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
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
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_favorites_category/dish_favorites_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal/widgets/meals_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/circle_plus_button/circle_plus_button.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';

@RoutePage()
class MealPage extends StatefulWidget {
  const MealPage({super.key});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  static const double _defaultNumberOfUnitsForDish = 1.0;

  @override
  void initState() {
    super.initState();

    // TODO hide recommendations after discussion with Diana 16.05.2024
    // final mealState = context.read<MealsBloc>().state;
    // final mealCategory = mealState.data.currentMealCategory;
    // if (mealCategory != null) {
    //   context.read<RecipeBloc>().add(RecipeEvent.getRecommendations(mealCategory));
    // }
  }

  void _onSaveToMyDishesHandler() {
    final state = context.read<MealsBloc>().state;

    final mealCategory = DishFavoritesCategory.values
            .asNameMap()
            .containsKey(state.data.currentMealCategory?.toLowerCase())
        ? state.data.currentMealCategory?.toLowerCase()
        : MealCategory.breakfast.originalValue;

    final mealId = state.data.getCurrentMealId;

    if (mealId == null || mealCategory == null) return;

    if (state.data.isContainsRecipeOrDish) {
      context.showError(content: CustomText(LocalizedTexts.invalidCreateDishFromMealMessage.tr()));
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
    final mealCategory = context.read<MealsBloc>().state.data.currentMealCategory;
    final mealId = context.read<MealsBloc>().state.data.getCurrentMealId;
    return '$mealCategory dish from meal $mealId';
  }

  String get _appBarTitle {
    final state = context.read<MealsBloc>().state;
    final currentMealCategory = state.data.currentMealCategory;

    if (currentMealCategory == null) return '';

    const AnalyticsEventService().logEvent(
      eventName:
          'meal_screen_type_${currentMealCategory.replaceAll(' ', '_').replaceFirst('&', 'and')}',
    );

    return '${currentMealCategory.capitalizeOnlyFirstLetter()}${' ${LocalizedTexts.logList.tr()}'}';
  }

  String get _appBarSubTitle {
    final state = context.read<MealsBloc>().state;

    final date =
        state.data.currentDateTime.isoStringWithoutTime != DateTime.now().isoStringWithoutTime
            ? state.data.currentDateTime.shortDate
            : LocalizedTexts.today.tr().capitalize();
    return date;
  }

  void _onChooseDates(BuildContext context) {
    final state = context.read<MealsBloc>().state.data;

    if (state.currentFoodItems.isNotEmpty) {
      context.router.push(
        ChooseDateCalendarRoute(
          mealCategory: state.currentMealCategory ?? '',
          dates: state.currentMeal?.planningDates,
          mealId: state.getCurrentMealId ?? -1,
        ),
      );
    }
  }

  void _onNutritionFactSelect(NutritionValuesTypes item) {
    context.read<MealsBloc>().add(MealsEvent.nutritionItemChanged(item));
  }

  // TODO hide recommendations after discussion with Diana 16.05.2024
  // _onRecommendationsPressed(BuildContext context) {
  //   final mealState = context.read<MealsBloc>().state;
  //   final mealCategory = mealState.data.currentMealCategory;
  //
  //   if (mealCategory != null) {
  //     context.router.push(
  //       RecommendationsRoute(
  //         mealCategory: mealCategory,
  //         date: mealState.data.currentDateTime,
  //         fromMealPage: true,
  //       ),
  //     );
  //   }
  // }

  _onDeleteMealPressed(BuildContext context) {
    final mealsState = context.read<MealsBloc>().state;
    final currentCategory = mealsState.data.currentMealCategory;
    final mealDates = mealsState.data.currentMealDates;

    if (currentCategory == null) return;

    if (mealDates != null && mealDates.length > 1) {
      ModalBottomSheet.deleteMultiDateMeal(
        context: context,
        onCanceled: () {
          context.router.maybePop();
          _onChooseDates(context);
        },
        onDeleted: () {
          context
              .read<MealsBloc>()
              .add(MealsEvent.deleteMeal(context.read<MealsBloc>().state.data.getCurrentMealId));

          // _setOriginDate();

          context.router.popUntilRouteWithName(HomeRoute.name);
        },
        mealCategory: currentCategory,
      );
    } else {
      ModalBottomSheet.deleteMeal(
        context: context,
        onDeleted: () {
          context
              .read<MealsBloc>()
              .add(MealsEvent.deleteMeal(context.read<MealsBloc>().state.data.getCurrentMealId));
          // Need  to observe behavior, and remove this after ~20 Feb 2024
          // _setOriginDate();

          context.router.popUntilRouteWithName(HomeRoute.name);
        },
        mealCategory: currentCategory,
      );
    }
  }

  _onBack() {
    final state = context.read<MealsBloc>().state;
    final hasMoreThanOneMealRouteInStack = context.router.stack
            .map((e) => e.name)
            .where((n) => n == context.router.current.name)
            .length >
        1;

    if (state.data.currentFoodItems.isEmpty && !hasMoreThanOneMealRouteInStack) {
      context.read<MealsBloc>().add(MealsEvent.deleteMeal(state.data.getCurrentMealId));
    }

    // _setOriginDate();
  }

  void _onBackToDashboardPressed() {
    _onBack();
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  Future<bool> _onWillPop() async {
    _onBack();

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (BuildContext context, state) {
        return WillPopScope(
          onWillPop: _onWillPop,
          child: CustomScaffold.greenLighter(
            appBar: CustomAppBar.green(
              title: _appBarTitle,
              subtitle: _appBarSubTitle,
              leading: CustomFilledIconButton.leadingGreenLighter(),
              actions: state.data.isEditable ? const [CirclePlusButton()] : null,
            ),
            body: CustomSafeArea(
              child: state.maybeMap(
                orElse: () => const SizedBox.shrink(),
                loading: (_) => const Loader(),
                error: (errorState) {
                  final error = errorState.data.error;
                  return ErrorScreen(
                    error: error!,
                    //TODO: need to check
                    onButtonPressed: () {
                      final mealId = context.read<MealsBloc>().state.data.getCurrentMealId;
                      if (mealId != null) {
                        context.read<MealsBloc>().add(MealsEvent.fetchMealById(mealId));
                      }
                    },
                  );
                },
                mealsInfo: (mealsState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NutritionValuesBlock(
                        numberOfPortions:
                            mealsState.data.currentMeal?.serving.numberOfUnits.toInt() ?? 0,
                        selectedNutritionType: mealsState.data.currentNutritionType,
                        nutritionValuesList:
                            mealsState.data.currentMeal?.serving.list ?? <NutritionItem>[],
                        onNutritionFactSelect: _onNutritionFactSelect,
                      ),
                      Expanded(
                        child: ScrollableContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MealsList(isActive: mealsState.data.isEditable),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: NutritionSummary(
                                  proteinDegree: state.data.currentMealProteinDegree,
                                  calorieDensity: state.data.currentMealCalorieDensity,
                                  fiber: state.data.currentMealFiber,
                                  carbFiberRatio: state.data.currentMealCarbFiberRatio,
                                  carbsPercent: state.data.currentMealCarbsPercent,
                                  totalCalories: state.data.currentMealCalories,
                                  totalCarbs: state.data.currentMealCarbsSum,
                                ),
                              ),
                              if (mealsState.data.isEditable)
                                MainContainer(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: CustomOutlinedButton.blueSmall(
                                              label: LocalizedTexts.saveToMyDishes.tr(),
                                              onPressed: _onSaveToMyDishesHandler,
                                            ),
                                          ),
                                          const SizedBox(width: 10.0),
                                          Expanded(
                                            child: CustomOutlinedButton.blueSmall(
                                              label: LocalizedTexts.clearMealList.tr(),
                                              onPressed: () => _onDeleteMealPressed(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // TODO hide recommendations after discussion with Diana 16.05.2024
                                      // const SizedBox(height: 10.0),

                                      // if (currentDate.isTodayOrFuture)
                                      //   BlocBuilder<RecipeBloc, RecipeState>(
                                      //     builder: (BuildContext context, recipeState) {
                                      //       return Row(
                                      //         children: [
                                      //           Expanded(
                                      //             child: CustomOutlinedButton.blueSmall(
                                      //               label: LocalizedTexts.recommendations.tr(),
                                      //               onPressed: () =>
                                      //                   recipeState.data.recommendationRecipe.isEmpty
                                      //                       ? null
                                      //                       : _onRecommendationsPressed(context),
                                      //             ),
                                      //           ),
                                      //           const Expanded(child: SizedBox(width: 10.0)),
                                      //         ],
                                      //       );
                                      //     },
                                      //   ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (mealsState.data.isEditable)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
                          child: CustomElevatedButton.blueFullWidth(
                            onPressed: _onBackToDashboardPressed,
                            label: LocalizedTexts.backToTodayLogging.tr(),
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
