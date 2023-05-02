import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_food_item_in_recipe_body.freezed.dart';

part 'update_food_item_in_recipe_body.g.dart';

@freezed
abstract class UpdateFoodItemInRecipeBody implements _$UpdateFoodItemInRecipeBody {
  const UpdateFoodItemInRecipeBody._();

  const factory UpdateFoodItemInRecipeBody({
    required double numberOfUnits,
    required String servingId,
  }) = _UpdateFoodItemInRecipeBody;

  factory UpdateFoodItemInRecipeBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateFoodItemInRecipeBodyFromJson(json);
}
