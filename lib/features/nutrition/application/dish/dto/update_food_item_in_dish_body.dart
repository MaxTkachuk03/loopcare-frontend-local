import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_food_item_in_dish_body.freezed.dart';

part 'update_food_item_in_dish_body.g.dart';

@freezed
abstract class UpdateFoodItemInDishBody implements _$UpdateFoodItemInDishBody {
  const UpdateFoodItemInDishBody._();

  const factory UpdateFoodItemInDishBody({
    required double numberOfUnits,
    required String servingId,
  }) = _UpdateFoodItemInDishBody;

  factory UpdateFoodItemInDishBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateFoodItemInDishBodyFromJson(json);
}
