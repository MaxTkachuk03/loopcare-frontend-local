import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/direction_item/direction_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';

part 'recipe_details.freezed.dart';

part 'recipe_details.g.dart';

@freezed
abstract class RecipeDetails implements _$RecipeDetails {
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
  }) = _RecipeDetails;

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
      if (!i.hasWeight) continue;

      caloriesSum += i.calories;
      proteinSum += i.servingProtein;
    }

    final result = (((proteinSum * 4) / caloriesSum) * 100);
    return (result.isNaN || result.isInfinite) ? 0 : result;
  }

  double get carbFiberRatio {
    double carbsSum = 0;
    double fiberSum = 0;

    for (var i in ingredients) {
      if (!i.hasWeight) continue;

      carbsSum += i.servingCarbohydrates;
      fiberSum += i.servingFiber;
    }

    final result = carbsSum / fiberSum;

    return (result.isNaN || result.isInfinite) ? 0 : result;
  }

  double get fiberSum {
    double fiberSum = 0;

    for (var i in ingredients) {
      if (!i.hasWeight) continue;

      fiberSum += i.servingFiber;
    }

    return fiberSum;
  }

  factory RecipeDetails.fromJson(Map<String, dynamic> json) => _$RecipeDetailsFromJson(json);
}
