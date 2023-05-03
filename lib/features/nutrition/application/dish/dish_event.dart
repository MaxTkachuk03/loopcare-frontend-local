part of 'dish_bloc.dart';

@freezed
class DishEvent with _$DishEvent {
  const factory DishEvent.setCurrentDish(Dish dish) = SetCurrentDish;

  const factory DishEvent.nutritionItemChanged(NutritionItem item) =
      NutritionItemChanged;
}
