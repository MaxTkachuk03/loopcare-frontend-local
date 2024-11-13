import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_recipe_to_meal_body.freezed.dart';

part 'add_recipe_to_meal_body.g.dart';

@freezed
abstract class AddRecipeToMealBody implements _$AddRecipeToMealBody {
  const AddRecipeToMealBody._();

  const factory AddRecipeToMealBody({
    required int numberOfUnits,
  }) = _AddRecipeToMealBody;

  factory AddRecipeToMealBody.fromJson(Map<String, dynamic> json) =>
      _$AddRecipeToMealBodyFromJson(json);
}
