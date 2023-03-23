part of 'select_food_bloc.dart';

@freezed
class SelectFoodState with _$SelectFoodState {
  const SelectFoodState._();

  const factory SelectFoodState.initial() = _Initial;

  const factory SelectFoodState.loading() = _Loading;

  const factory SelectFoodState.selectFood({
    required IList<FoodItem> favorites,
    required IList<dynamic> dishes,
    required IList<String> selectedFavoritesItems,
    required IList<MealCategoryFilter> mealFavoritesCategories,
  }) = _SelectFood;

  const factory SelectFoodState.error(RequestError fetchError) = _Error;

  int get selectedFavoritesItemsLength {
    return mapOrNull(
            selectFood: (state) => state.selectedFavoritesItems.length) ??
        0;
  }
}
