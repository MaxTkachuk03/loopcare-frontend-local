part of 'dish_bloc.dart';

@freezed
class DishEvent with _$DishEvent {
  const factory DishEvent.getClonedDish(int dishId) = GetClonedDish;

  const factory DishEvent.getDishById(int dishId) = GetDishById;

  const factory DishEvent.nutritionItemChanged(NutritionValuesTypes item) = NutritionItemChanged;

  const factory DishEvent.servingChanged({
    required int mealId,
    required int servingAmount,
  }) = ServingChanged;

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

  const factory DishEvent.addFoodItemToDish({
    required double numberOfUnits,
    required String servingId,
    required String externalFoodItemId,
  }) = AddFoodItemToDish;
}
