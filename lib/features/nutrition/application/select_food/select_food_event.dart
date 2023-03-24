part of 'select_food_bloc.dart';

@freezed
class SelectFoodEvent with _$SelectFoodEvent {
  const factory SelectFoodEvent.fetchFavorites() = FetchFavorites;

  const factory SelectFoodEvent.filterFavorites(
    IList<MealCategoryFilter> filtersList,
  ) = FilterFavorites;

  const factory SelectFoodEvent.itemAdded(String id) = ItemAdded;

  const factory SelectFoodEvent.itemDeleted(String id) = ItemDeleted;

  const factory SelectFoodEvent.itemsDeselectAll() = ItemsDeselectAll;
}
