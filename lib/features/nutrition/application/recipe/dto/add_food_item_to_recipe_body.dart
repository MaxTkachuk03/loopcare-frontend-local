import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_food_item_to_recipe_body.freezed.dart';

part 'add_food_item_to_recipe_body.g.dart';

@freezed
abstract class AddFoodItemToRecipeBody implements _$AddFoodItemToRecipeBody {
  const AddFoodItemToRecipeBody._();

  const factory AddFoodItemToRecipeBody({
    required double numberOfUnits,
    required String servingId,
  }) = _AddFoodItemToRecipeBody;

  factory AddFoodItemToRecipeBody.fromJson(Map<String, dynamic> json) =>
      _$AddFoodItemToRecipeBodyFromJson(json);
}
