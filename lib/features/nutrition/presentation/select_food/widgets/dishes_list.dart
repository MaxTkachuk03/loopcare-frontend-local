import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_favorites_category/dish_favorites_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/dish_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/empty_list_widget.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/list_filters.dart';

class DishesList extends StatefulWidget {
  final String mealCategory;

  const DishesList({
    super.key,
    required this.mealCategory,
  });

  @override
  State<DishesList> createState() => _DishesListState();
}

class _DishesListState extends State<DishesList> with AutomaticKeepAliveClientMixin {
  static const double _defaultNewDishNumberOfUnits = 1.0;
  static const String _defaultNewDishName = 'new dish';

  @override
  bool wantKeepAlive = true;

  @override
  void initState() {
    context.read<SelectFoodBloc>().add(SelectFoodEvent.fetchDishes(_defaultMealCategory));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AnalyticsEventService.instance.logEvent(FirebaseEvents.selectFoodScreenMyDishes);
  }

  Future _onRefresh() async {
    return context.read<SelectFoodBloc>().add(SelectFoodEvent.fetchDishes(_defaultMealCategory));
  }

  _updateDishesListener(BuildContext context, state) {
    context.read<SelectFoodBloc>().add(SelectFoodEvent.fetchDishes(_defaultMealCategory));
  }

  bool get _canCreateDishWithSelectedMealCategory {
    return DishFavoritesCategory.values.asNameMap().containsKey(widget.mealCategory.toLowerCase());
  }

  String get _defaultMealCategory {
    return _canCreateDishWithSelectedMealCategory
        ? widget.mealCategory.toLowerCase()
        : MealCategory.breakfast.name.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<EditDishBloc, EditDishState>(
      listener: _updateDishesListener,
      listenWhen: (prev, cur) => prev != cur,
      child: Column(
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
                      onButtonPressed: () => context
                          .read<SelectFoodBloc>()
                          .add(SelectFoodEvent.fetchFavorites(_defaultMealCategory)),
                    ),
                  );
                },
                selectFood: (selectFoodState) {
                  final String title = selectFoodState.hasOneSelectedDishCategory
                      ? '${LocalizedTexts.my.tr()} ${selectFoodState.selectedDishCategories[0].name}'
                      : LocalizedTexts.myDishes.tr();

                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListFilters(
                          title: title,
                          mealsList: selectFoodState.dishFavoritesCategories.toList(),
                          onConfirmed: (list) => _onConfirmed(context, list),
                        ),
                        selectFoodState.dishes.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    EmptyListWidget(
                                      type: EmptyListType.myDishes,
                                      typeText: title,
                                    ),
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
                                  onRefresh: _onRefresh,
                                  child: ListView.separated(
                                    itemCount: selectFoodState.dishes.length + 1,
                                    itemBuilder: (BuildContext context, int index) {
                                      if (index == selectFoodState.dishes.length) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 8.0),
                                            if (_canCreateDishWithSelectedMealCategory)
                                              MainContainer(
                                                child: CustomOutlinedButton.blueSmall(
                                                  label: LocalizedTexts.createMyDish.tr(),
                                                  onPressed: _onCreateDish,
                                                ),
                                              )
                                          ],
                                        );
                                      }
                                      return DishListItem(
                                        dishItem: selectFoodState.dishes[index],
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                                      return const Divider(
                                        height: 1,
                                        color: AppColors.blueLighter,
                                      );
                                    },
                                  ),
                                ),
                              ),
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
      ),
    );
  }

  void _onCreateDish() {
    context.router.push(
      EditDishRoute(
        mode: EditDishPageMode.create,
        event: EditDishEvent.createDish(
            _defaultNewDishName, _defaultNewDishNumberOfUnits, _selectedMealCategories),
      ),
    );
  }

  List<MealCategory> get _selectedMealCategories {
    List<MealCategory> defaultMealCategories = [];

    for (final mealCategory in MealCategory.values) {
      if (mealCategory.name.toLowerCase() == widget.mealCategory.toLowerCase()) {
        defaultMealCategories.add(mealCategory);
      }
    }

    return defaultMealCategories;
  }

  _onConfirmed(BuildContext context, List<MealCategoryFilter> updatedFiltersList) {
    context.read<SelectFoodBloc>().add(SelectFoodEvent.filterDishes(updatedFiltersList.toIList()));
  }
}
