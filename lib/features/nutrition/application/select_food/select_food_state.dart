part of 'select_food_bloc.dart';

@freezed
class SelectFoodState with _$SelectFoodState {
  const SelectFoodState._();

  const factory SelectFoodState.initial() = _Initial;

  const factory SelectFoodState.loading() = _Loading;

  const factory SelectFoodState.selectFood({
    required IList<FavoritesItem> favorites,
    required IList<Dish> dishes,
    required IList<FavoritesItem> selectedFavoritesItems,
    required IList<MealCategoryFilter> mealFavoritesCategories,
    required IList<MealCategoryFilter> dishFavoritesCategories,
  }) = _SelectFood;

//TODO: old state style
  const factory SelectFoodState.error(RequestError fetchError) = _Error;

  List<FavoritesItem> get selectedFavoritesItemsList {
    return mapOrNull(
          selectFood: (state) => state.selectedFavoritesItems.toList(),
        ) ??
        <FavoritesItem>[];
  }

  int get selectedFavoritesItemsLength {
    return mapOrNull(
          selectFood: (state) => state.selectedFavoritesItems.length,
        ) ??
        0;
  }

  List<MealCategoryFilter> get selectedMealCategories {
    return mapOrNull(selectFood: (state) => state.mealFavoritesCategories.where((e) => e.selected))
            ?.toList() ??
        [];
  }

  List<MealCategoryFilter> get selectedDishCategories {
    return mapOrNull(selectFood: (state) => state.dishFavoritesCategories.where((e) => e.selected))
            ?.toList() ??
        [];
  }

  bool get hasOneSelectedMealCategory {
    return mapOrNull(
            selectFood: (state) =>
                state.mealFavoritesCategories
                    .where((e) => e.selected && e.name != MealFavoritesCategory.all.name)
                    .length ==
                1) ??
        false;
  }

  bool get hasOneSelectedDishCategory {
    return mapOrNull(
            selectFood: (state) =>
                state.dishFavoritesCategories.where((e) => e.selected).length == 1) ??
        false;
  }
}
