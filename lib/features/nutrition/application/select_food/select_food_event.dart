part of 'select_food_bloc.dart';

@freezed
class SelectFoodEvent with _$SelectFoodEvent {
  const factory SelectFoodEvent.fetchFavorites(String mealCategory) =
      FetchFavorites;

  const factory SelectFoodEvent.fetchDishes(String mealCategory) = FetchDishes;

  const factory SelectFoodEvent.filterFavorites(
    List<MealCategoryFilter> filtersList,
  ) = FilterFavorites;

  const factory SelectFoodEvent.filterDishes(
    List<MealCategoryFilter> filtersList,
  ) = FilterDishes;

  const factory SelectFoodEvent.itemAdded(FavoritesItem foodItem) = ItemAdded;

  const factory SelectFoodEvent.itemDeleted(FavoritesItem foodItem) =
      ItemDeleted;

  const factory SelectFoodEvent.dishAdded(Dish foodItem) = DishAdded;

  const factory SelectFoodEvent.dishDeleted(Dish foodItem) = DishDeleted;

  const factory SelectFoodEvent.itemsDeselectAll(SearchMode mode) = ItemsDeselectAll;

  const factory SelectFoodEvent.removeDish(UpdateDishFoodItemResponse dish) =
      RemoveDish;
}
