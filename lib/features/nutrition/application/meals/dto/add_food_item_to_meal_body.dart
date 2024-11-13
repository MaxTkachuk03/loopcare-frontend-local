import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_food_item_to_meal_body.freezed.dart';

part 'add_food_item_to_meal_body.g.dart';

@freezed
abstract class AddFoodItemToMealBody implements _$AddFoodItemToMealBody {
  const factory AddFoodItemToMealBody({
    required double? numberOfUnits,
    required String servingId,
  }) = _AddFoodItemToMealBody;
  const AddFoodItemToMealBody._();

  factory AddFoodItemToMealBody.fromJson(Map<String, dynamic> json) =>
      _$AddFoodItemToMealBodyFromJson(json);
}
