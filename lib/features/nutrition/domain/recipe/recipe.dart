import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'recipe.freezed.dart';

part 'recipe.g.dart';

@freezed
class Recipe with _$Recipe {
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
    @Default(ServingSize()) ServingSize servingSize,
  }) = _Recipe;

  double get _servingCalories => servingSize.calories;
  double get _servingWeight => servingSize.metricServingAmount;
  double get _servingProtein => servingSize.protein;
  double get _servingCarbs => servingSize.carbohydrate;
  double get _servingFiber => servingSize.fiber;

  double get fiberSum => _servingFiber;

  double get calorieDensityVal {
    final result = _servingCalories / _servingWeight;
    return result.isNaN || result.isInfinite ? 0 : result;
  }

  double get proteinDegreeVal {
    final result = (((_servingProtein * 4) / _servingCalories) * 100);
    return (result.isNaN || result.isInfinite) ? 0 : result;
  }

  double get carbFiberRatio {
    final result = _servingCarbs / _servingFiber;
    return (result.isNaN || result.isInfinite) ? 0 : result;
  }

  double get carbsPercent {
    final result = ((_servingCarbs * 4) / _servingCalories) * 100;
    return (result.isNaN || result.isInfinite) ? 0 : result;
  }

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
