import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/direction_item/direction_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'recipe_details.freezed.dart';

part 'recipe_details.g.dart';

@freezed
class RecipeDetails with _$RecipeDetails {
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

  factory RecipeDetails.fromJson(Map<String, dynamic> json) => _$RecipeDetailsFromJson(json);
}
