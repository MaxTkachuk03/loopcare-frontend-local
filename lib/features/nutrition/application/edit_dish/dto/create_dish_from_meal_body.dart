import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_dish_from_meal_body.freezed.dart';

part 'create_dish_from_meal_body.g.dart';

@freezed
abstract class CreateDishFromMealBody implements _$CreateDishFromMealBody {
  const CreateDishFromMealBody._();

  const factory CreateDishFromMealBody({
    required int mealId,
    required double numberOfUnits,
    required String mealCategory,
    required String name,
  }) = _CreateDishFromMealBody;

  factory CreateDishFromMealBody.fromJson(Map<String, dynamic> json) =>
      _$CreateDishFromMealBodyFromJson(json);
}
