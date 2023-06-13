import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_dish_in_meal_body.freezed.dart';

part 'update_dish_in_meal_body.g.dart';

@freezed
abstract class UpdateDishInMealBody implements _$UpdateDishInMealBody {
  const UpdateDishInMealBody._();

  const factory UpdateDishInMealBody({
    required int numberOfUnits,
  }) = _UpdateDishInMealBody;

  factory UpdateDishInMealBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateDishInMealBodyFromJson(json);
}
