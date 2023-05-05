part of 'food_item_servings_bloc.dart';

@freezed
class FoodItemServingsEvent with _$FoodItemServingsEvent {
  const factory FoodItemServingsEvent.fetchFoodItemServings(
    String foodItemId,
    String? selectedServingId,
    double initialServingAmount,
  ) = FetchFoodItemServings;

  const factory FoodItemServingsEvent.setSelectedFoodItemServing(
    FoodItemServing item,
  ) = SetSelectedFoodItemServing;

  const factory FoodItemServingsEvent.addToFavorites(
    String foodItemId,
  ) = AddToFavorites;

  const factory FoodItemServingsEvent.removeFromFavorites(
    String foodItemId,
    String? servingId,
  ) = RemoveFromFavorites;

  const factory FoodItemServingsEvent.updateFavorite(
    String foodItemId,
  ) = UpdateFavorite;

  const factory FoodItemServingsEvent.setSelectedServingAmount(
    String amount,
  ) = SetSelectedServingAmount;

  const factory FoodItemServingsEvent.setMealCategoryFilters(
    List<MealCategoryFilter> filters,
  ) = SetMealCategoryFilters;

  const factory FoodItemServingsEvent.updateMealCategoryFilter(
    bool value,
    String name,
  ) = UpdateMealCategoryFilter;
}
