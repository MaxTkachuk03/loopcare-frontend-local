part of 'edit_dish_bloc.dart';

@freezed
class EditDishState with _$EditDishState {
  const EditDishState._();

  const factory EditDishState.initial() = Initial;

  const factory EditDishState.loading() = Loading;

  const factory EditDishState.deleted() = Deleted;

  const factory EditDishState.saved() = Saved;

  const factory EditDishState.error(RequestError fetchError) = Error;

  const factory EditDishState.dishInfo({
    required Dish currentDish,
    @Default(NutritionValuesTypes.calories)
        NutritionValuesTypes currentNutritionType,
  }) = DishInfo;

  String get servingAmount {
    return maybeMap(
      dishInfo: (s) => s.currentDish.serving.numberOfUnits.toString(),
      orElse: () => '1',
    );
  }

  bool get hasFoodItems {
    return maybeMap(
      dishInfo: (s) => s.currentDish.foodItems.isNotEmpty,
      orElse: () => false,
    );
  }

  String get numberOfServings {
    return maybeMap(
      dishInfo: (s) => s.currentDish.serving.numberOfUnits.toString(),
      orElse: () => '',
    );
  }

  String get numberOfPortions {
    return maybeMap(
      dishInfo: (s) => s.currentDish.numberOfServings.toString(),
      orElse: () => '',
    );
  }
}
