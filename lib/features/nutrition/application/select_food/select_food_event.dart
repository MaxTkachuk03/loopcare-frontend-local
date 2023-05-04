part of 'select_food_bloc.dart';

@freezed
class SelectFoodEvent with _$SelectFoodEvent {
  const factory SelectFoodEvent.fetchFavorites() = FetchFavorites;

  const factory SelectFoodEvent.fetchDishes() = FetchDishes;

  const factory SelectFoodEvent.filterFavorites(
    IList<MealCategoryFilter> filtersList,
  ) = FilterFavorites;

  const factory SelectFoodEvent.filterDishes(
    IList<MealCategoryFilter> filtersList,
  ) = FilterDishes;

  const factory SelectFoodEvent.itemAdded(FoodItem foodItem) = ItemAdded;

  const factory SelectFoodEvent.itemDeleted(FoodItem foodItem) = ItemDeleted;

  const factory SelectFoodEvent.itemsDeselectAll() = ItemsDeselectAll;
}
