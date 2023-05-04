part of 'dish_bloc.dart';

@freezed
class DishEvent with _$DishEvent {
  const factory DishEvent.setCurrentDish(Dish dish) = SetCurrentDish;

  const factory DishEvent.nutritionItemChanged(NutritionItem item) =
      NutritionItemChanged;

  const factory DishEvent.updateFoodItemInDish({
    required int dishId,
    required String internalFoodItemId,
    required double numberOfUnits,
    required String servingId,
  }) = UpdateFoodItemInDish;

  const factory DishEvent.deleteFoodItemFromDish({
    required int dishId,
    required String internalFoodItemId,
  }) = DeleteFoodItemFromDish;

  const factory DishEvent.deleteFoodItemFromDishLocally({
    required int foodItemId,
  }) = DeleteFoodItemFromDishLocally;

  const factory DishEvent.addToMeal(int mealId, String numberOfServings) =
      AddToMeal;
}
