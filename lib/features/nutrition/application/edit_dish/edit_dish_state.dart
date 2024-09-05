part of 'edit_dish_bloc.dart';

@freezed
class EditDishState with _$EditDishState {
  const EditDishState._();

  const factory EditDishState.initial(EditDishData data) = Initial;

  const factory EditDishState.loading(EditDishData data) = Loading;

  const factory EditDishState.deleted(EditDishData data) = Deleted;

  const factory EditDishState.saved(EditDishData data) = Saved;

  const factory EditDishState.error(EditDishData data) = Error;

  const factory EditDishState.dishInfo(EditDishData data) = DishInfo;
}

@freezed
class EditDishData with _$EditDishData {
  const EditDishData._();

  const factory EditDishData({
    Dish? currentDish,
    @Default(NutritionValuesTypes.calories) NutritionValuesTypes currentNutritionType,
    @Default(false) isLoading,
    RequestError? error,
  }) = _EditDishData;

  String get servingAmount => currentDish?.serving.numberOfUnits.toString() ?? '1';

  bool get hasFoodItems => currentDish?.foodItems.isNotEmpty ?? false;

  String get numberOfServings => currentDish?.serving.numberOfUnits.toString() ?? '1';

  String get numberOfPortions => currentDish?.numberOfServings.toString() ?? '1';
}