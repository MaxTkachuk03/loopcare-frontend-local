import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish/dish.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_favorites_category/dish_favorites_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/favorites_item/favorites_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/dish_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/empty_list_widget.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/favorite_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/footer_overlay.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/list_filters.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class DishesAndFavorites extends StatefulWidget {
  final MealCategory? mealCategory;

  const DishesAndFavorites({
    super.key,
    required this.mealCategory,
  });

  @override
  State<DishesAndFavorites> createState() => _DishesAndFavoritesState();
}

class _DishesAndFavoritesState extends State<DishesAndFavorites>
    with AutomaticKeepAliveClientMixin {
  static const double _defaultNewDishNumberOfUnits = 1.0;
  static const String _defaultNewDishName = 'new dish';
  late TextEditingController _servingController;
  List<MealCategoryFilter> favoritesCategories = [];
  List<Object> combinedList = [];

  @override
  bool wantKeepAlive = true;

  @override
  void initState() {
    context
        .read<SelectFoodBloc>()
        .add(SelectFoodEvent.fetchFavorites(_defaultMealCategoryFavorites));

    const AnalyticsEventService()
        .logEvent(eventName: AnalyticsEvents.selectFoodScreenMyFavorites);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context
            .read<SelectFoodBloc>()
            .add(SelectFoodEvent.fetchDishes(_defaultMealCategory));
      }
      const AnalyticsEventService()
          .logEvent(eventName: AnalyticsEvents.selectFoodScreenMyDishes);
    });

    _servingController = TextEditingController(
        text: context.read<DishBloc>().state.servingAmount);

    super.initState();
  }

  @override
  void dispose() {
    _servingController.dispose();
    super.dispose();
  }

  Future _onRefreshDishes() async {
    return context
        .read<SelectFoodBloc>()
        .add(SelectFoodEvent.fetchDishes(_defaultMealCategory));
  }

  Future _onRefreshFavorites() async {
    return context
        .read<SelectFoodBloc>()
        .add(SelectFoodEvent.fetchFavorites(_defaultMealCategoryFavorites));
  }

  // _updateDishesListener(BuildContext context, state) {
  //   context
  //       .read<SelectFoodBloc>()
  //       .add(SelectFoodEvent.fetchFavorites(_defaultMealCategoryFavorites));

  //   context
  //       .read<SelectFoodBloc>()
  //       .add(SelectFoodEvent.fetchDishes(_defaultMealCategory));
  // }

  bool get _canCreateDishWithSelectedMealCategory {
    return DishFavoritesCategory.values
        .asNameMap()
        .containsKey(widget.mealCategory?.name);
  }

  String get _defaultMealCategory => _canCreateDishWithSelectedMealCategory
      ? widget.mealCategory?.originalValue ?? ''
      : MealCategory.breakfast.name;

  String get _defaultMealCategoryFavorites =>
      widget.mealCategory?.originalValue ?? '';

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<SelectFoodBloc, SelectFoodState>(
          builder: (BuildContext context, state) {
            return state.maybeMap(
              error: (errorState) {
                final error = errorState.fetchError;

                return Center(
                  child: ErrorScreen(
                    error: error,
                    onButtonPressed: () => context.read<SelectFoodBloc>().add(
                        SelectFoodEvent.fetchFavorites(
                            _defaultMealCategoryFavorites)),
                  ),
                );
              },
              selectFood: (selectFoodState) {
                final String title = selectFoodState.hasOneSelectedDishCategory
                    ? '${LocalizedTexts.my.tr()} ${selectFoodState.selectedDishCategories[0].name}'
                    : LocalizedTexts.myDishes.tr();

                combinedList = [
                  ...selectFoodState.favorites,
                  ...selectFoodState.dishes
                ];

                // favoritesCategories = [
                //   ...selectFoodState.dishFavoritesCategories,
                //   ...selectFoodState.mealFavoritesCategories
                // ];

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListFilters(
                          title: title,
                          mealsList:
                              selectFoodState.mealFavoritesCategories.toList(),
                          onConfirmed: _onConfirmed),
                      selectFoodState.dishes.isEmpty &&
                              selectFoodState.favorites.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EmptyListWidget(
                                    type: EmptyListType.myFavorites,
                                    typeText: title,
                                  ),
                                  // const SizedBox(height: 20.0),
                                  // EmptyListWidget(
                                  //   type: EmptyListType.myDishes,
                                  //   typeText: title,
                                  // ),
                                  const SizedBox(height: 20.0),
                                  if (_canCreateDishWithSelectedMealCategory)
                                    MainContainer(
                                      child: CustomOutlinedButton.blueSmall(
                                        label: LocalizedTexts.createMyDish.tr(),
                                        onPressed: _onCreateDish,
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  await _onRefreshFavorites();
                                  Future.delayed(
                                      const Duration(milliseconds: 800),
                                      () async {
                                    await _onRefreshDishes();
                                  });
                                },
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: combinedList.toList().length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (combinedList.toList()[index]
                                        is FavoritesItem) {
                                      return FavoriteListItem(
                                        foodItem: combinedList.toList()[index]
                                            as FavoritesItem,
                                      );
                                    }

                                    return DishListItem(
                                      dishItem:
                                          combinedList.toList()[index] as Dish,
                                    );
                                  },
                                ),
                              ),
                            ),
                      state.selectedDishesItemsLength > 0 ||
                              state.selectedFavoritesItemsLength > 0
                          ? FooterOverlay(
                              servingController: _servingController,
                              dishes: selectFoodState.selectedDishesItems,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                );
              },
              loading: (_) => const Expanded(child: Loader()),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }

  void _onCreateDish() {
    context.router.push(
      EditDishRoute(
        mode: EditDishPageMode.create,
        event: EditDishEvent.createDish(_defaultNewDishName,
            _defaultNewDishNumberOfUnits, _selectedMealCategories),
      ),
    );
  }

  List<MealCategory> get _selectedMealCategories {
    List<MealCategory> defaultMealCategories = [];

    for (final mealCategory in MealCategory.values) {
      if (mealCategory == widget.mealCategory) {
        defaultMealCategories.add(mealCategory);
      }
    }

    return defaultMealCategories;
  }

  void _onConfirmed(List<MealCategoryFilter> list) =>
      context.read<SelectFoodBloc>().add(SelectFoodEvent.filterFavorites(list));
}
