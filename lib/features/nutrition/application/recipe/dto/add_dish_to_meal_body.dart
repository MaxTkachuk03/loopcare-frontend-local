import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_dish_to_meal_body.freezed.dart';

part 'add_dish_to_meal_body.g.dart';

@freezed
abstract class AddDishToMealBody implements _$AddDishToMealBody {
  const AddDishToMealBody._();

  const factory AddDishToMealBody({
    required int dishId,
    required int numberOfUnits,
  }) = _AddDishToMealBody;

  factory AddDishToMealBody.fromJson(Map<String, dynamic> json) =>
      _$AddDishToMealBodyFromJson(json);
}
