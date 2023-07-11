part of 'dish_bloc.dart';

@freezed
class DishState with _$DishState {
  const DishState._();

  const factory DishState.initial() = _Initial;

  const factory DishState.loading() = _Loading;

//TODO: old state style
  const factory DishState.error(RequestError fetchError) = _Error;

  const factory DishState.dish({
    required Dish selectedDish,
    required int originalDishId,
    @Default(NutritionValuesTypes.calories) NutritionValuesTypes currentNutritionType,
  }) = _Dish;

  String get servingAmount {
    return maybeMap(
      dish: (s) => s.selectedDish.serving.numberOfUnits.toString(),
      orElse: () => '1',
    );
  }

  Dish? get dish {
    return mapOrNull(dish: (s) => s.selectedDish);
  }

  bool get hasFoodItems {
    return maybeMap(
      dish: (s) => s.selectedDish.foodItems.isNotEmpty,
      orElse: () => false,
    );
  }
}
