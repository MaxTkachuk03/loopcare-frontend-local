part of 'food_item_servings_bloc.dart';

@freezed
class FoodItemServingsEvent with _$FoodItemServingsEvent {
  const factory FoodItemServingsEvent.fetchFoodItemServings({
    required String foodItemId,
    String? selectedServingId,
    required double initialServingAmount,
    double? initialCaloriesValue,
  }) = FetchFoodItemServings;

  const factory FoodItemServingsEvent.setSelectedFoodItemServing(
    ServingSize item,
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
