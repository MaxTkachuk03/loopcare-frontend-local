import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_utils.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'recipe.freezed.dart';

part 'recipe.g.dart';

@freezed
class Recipe with _$Recipe, NutritionUtils {
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

  double get servingCalories => servingSize.calories;
  double get _servingWeight => servingSize.metricServingAmount;
  double get _servingProtein => servingSize.protein;
  double get _servingCarbs => servingSize.carbohydrate;
  double get _servingFiber => servingSize.fiber;
  double get _servings => servingSize.numberOfUnits;

  double get fiberSum => _servingFiber * _servings;

  double get totalCalories => servingCalories * _servings;

  double get totalCarbs => _servingCarbs * _servings;

  double get calorieDensityVal => getCalorieDensity(servingCalories, _servingWeight);

  double get proteinDegreeVal => getProteinDegree(_servingProtein, servingCalories);

  double get carbFiberRatio => getCarbFiberRatio(_servingCarbs, _servingFiber);

  double get carbsPercent => getCarbsPercent(_servingCarbs, servingCalories);

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
