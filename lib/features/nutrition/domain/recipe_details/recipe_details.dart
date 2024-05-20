import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_utils.dart';
import 'package:loopcare_frontend/features/nutrition/domain/direction_item/direction_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'recipe_details.freezed.dart';

part 'recipe_details.g.dart';

@freezed
class RecipeDetails with _$RecipeDetails, NutritionUtils {
  const RecipeDetails._();

  const factory RecipeDetails({
    required int id,
    required String name,
    required String description,
    required List<String>? image,
    required List<DirectionItem> directions,
    required int cookingTimeMin,
    required int preparationTimeMin,
    required List<RecipeFoodItem> ingredients,
    required double calorieDensity,
    required double proteinDegree,
    required List<NutritionItem> nutritionValues,
    required int numberOfServings,
    required double servingAmount,
    required ServingSize servingSize,
  }) = _RecipeDetails;

  double get servingCalories => servingSize.calories;
  double get _servingWeight => servingSize.metricServingAmount;
  double get _servingProtein => servingSize.protein;
  double get _servingCarbs => servingSize.carbohydrate;
  double get _servingFiber => servingSize.fiber;

  double get fiberSum => _servingFiber;

  double get carbsSum => _servingCarbs;

  double get calorieDensityVal => getCalorieDensity(servingCalories, _servingWeight);

  double get proteinDegreeVal => getProteinDegree(_servingProtein, servingCalories);

  double get carbFiberRatio => getCarbFiberRatio(_servingCarbs, _servingFiber);

  double get carbsPercent => getCarbsPercent(_servingCarbs, servingCalories);

  factory RecipeDetails.fromJson(Map<String, dynamic> json) => _$RecipeDetailsFromJson(json);
}
