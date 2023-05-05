part of 'dish_bloc.dart';

@freezed
class DishState with _$DishState {
  const DishState._();

  const factory DishState.initial() = _Initial;

  const factory DishState.loading() = _Loading;

  const factory DishState.error(RequestError fetchError) = _Error;

  const factory DishState.dish({
    required Dish selectedDish,
    required int originalDishId,
    required NutritionItem currentNutritionItem,
  }) = _Dish;

  String get servingAmount {
    return maybeMap(
      dish: (s) => s.selectedDish.serving.numberOfUnits.toString(),
      orElse: () => '1',
    );
  }
}
