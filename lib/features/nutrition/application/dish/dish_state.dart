part of 'dish_bloc.dart';

@freezed
class DishState with _$DishState {
  const DishState._();

  const factory DishState.initial() = _Initial;

  const factory DishState.loading() = _Loading;

  const factory DishState.dish({
    required Dish selectedDish,
    required NutritionItem currentNutritionItem,
  }) = _Dish;
}
