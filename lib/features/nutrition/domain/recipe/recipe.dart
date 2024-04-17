import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';

part 'recipe.freezed.dart';

part 'recipe.g.dart';

@freezed
abstract class Recipe implements _$Recipe {
  const Recipe._();

  const factory Recipe({
    @Default(0) int id,
    @Default('') String externalId,
    @Default([]) List<RecipeFoodItem> ingredients,
    @Default(0) double calorieDensity,
    @Default(0) double proteinDegree,
    @Default([]) List<NutritionItem> nutritionValues,
    @Default(0) int numberOfServings,
    @Default(0) double servingAmount,
  }) = _Recipe;

  double get calorieDensityVal {
    double caloriesSum = 0;
    double amountSum = 0;

    for (var i in ingredients) {
      if (!i.hasWeight) continue;

      caloriesSum += i.calories;
      amountSum += i.servingWeight;
    }

    final result = caloriesSum / amountSum;
    return result.isNaN || result.isInfinite ? 0 : result;
  }

  double get proteinDegreeVal {
    double caloriesSum = 0;
    double proteinSum = 0;

    for (var i in ingredients) {
      caloriesSum += i.calories;
      proteinSum += i.servingProtein;
    }

    final result = (((proteinSum * 4) / caloriesSum) * 100);
    return (result.isNaN || result.isInfinite) ? 0 : result;
  }

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
