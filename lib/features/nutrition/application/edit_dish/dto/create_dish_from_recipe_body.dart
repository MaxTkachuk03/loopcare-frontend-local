import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_favorites_category/dish_favorites_category.dart';

part 'create_dish_from_recipe_body.freezed.dart';

part 'create_dish_from_recipe_body.g.dart';

@freezed
abstract class CreateDishFromRecipeBody implements _$CreateDishFromRecipeBody {
  const CreateDishFromRecipeBody._();

  const factory CreateDishFromRecipeBody({
    int? mealRecipeId,
    int? recipeId,
    required double numberOfUnits,
    required List<DishFavoritesCategory> mealCategories,
  }) = _CreateDishFromRecipeBody;

  factory CreateDishFromRecipeBody.fromJson(Map<String, dynamic> json) =>
      _$CreateDishFromRecipeBodyFromJson(json);
}
