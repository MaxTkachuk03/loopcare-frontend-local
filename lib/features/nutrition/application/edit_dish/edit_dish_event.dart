part of 'edit_dish_bloc.dart';

@freezed
class EditDishEvent with _$EditDishEvent {
  const factory EditDishEvent.getDish(int id) = GetDish;

  const factory EditDishEvent.createDishFromRecipe(
    int mealRecipeId,
    double numberOfUnits,
    List<MealCategory> mealCategories,
  ) = CreateDishFromRecipe;

  const factory EditDishEvent.createDishFromMeal(
    int mealId,
    double numberOfUnits,
    String mealCategory,
    String name,
  ) = CreateDishFromMeal;

  const factory EditDishEvent.createDish(
    String name,
    double numberOfUnits,
    List<MealCategory> mealCategories,
  ) = CreateDish;

  const factory EditDishEvent.nutritionItemChanged(NutritionItem item) =
      NutritionItemChanged;

  const factory EditDishEvent.addFoodItemToDish({
    required double numberOfUnits,
    required String servingId,
    required String externalFoodItemId,
  }) = AddFoodItemToDish;

  const factory EditDishEvent.deleteFoodItemFromDish({
    required int dishId,
    required int internalFoodItemId,
  }) = DeleteFoodItemFromDish;

  const factory EditDishEvent.updateFoodItemInDish({
    required int dishId,
    required String internalFoodItemId,
    required double numberOfUnits,
    required String servingId,
  }) = UpdateFoodItemInDish;

  const factory EditDishEvent.deleteDish() = DeleteDish;

  const factory EditDishEvent.updateDish({
    required String name,
    required double numberOfUnits,
    required double numberOfServings,
    required List<MealCategory> mealCategories,
  }) = UpdateDish;
}
