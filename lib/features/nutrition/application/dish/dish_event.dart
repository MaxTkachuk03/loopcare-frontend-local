part of 'dish_bloc.dart';

@freezed
class DishEvent with _$DishEvent {
  const factory DishEvent.getClonedDish(int dishId) = GetClonedDish;

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
    required int internalFoodItemId,
  }) = DeleteFoodItemFromDish;

  const factory DishEvent.addToMeal(int mealId, String numberOfServings) =
      AddToMeal;

  const factory DishEvent.addFoodItemToDish({
    required double numberOfUnits,
    required String servingId,
    required String externalFoodItemId,
  }) = AddFoodItemToDish;
}
