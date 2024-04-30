import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'dish.freezed.dart';

part 'dish.g.dart';

@freezed
abstract class Dish implements _$Dish {
  const Dish._();

  const factory Dish({
    required int id,
    required double numberOfServings,
    required String name,
    required List<DishFoodItem> foodItems,
    required List<MealCategory> mealCategories,
    required int? recipeId,
    required double calorieDensity,
    required double proteinDegree,
    required DateTime createdAt,
    required DateTime updatedAt,
    required ServingSize serving,
  }) = _Dish;

  double get caloriesSum {
    double caloriesSum = 0;

    for (var item in foodItems) {
      if (!item.hasWeight || item.excludedFromCalculations) continue;

      caloriesSum += item.servingCalories;
    }

    return caloriesSum;
  }

  double get fiberSum {
    double fiberSum = 0;

    for (var item in foodItems) {
      if (!item.hasWeight || item.excludedFromCalculations) continue;

      fiberSum += item.servingFiber;
    }

    return fiberSum;
  }

  double get carbohydratesSum {
    double carbohydratesSum = 0;

    for (var item in foodItems) {
      if (!item.hasWeight || item.excludedFromCalculations) continue;

      carbohydratesSum += item.servingCarbs;
    }

    return carbohydratesSum;
  }

  double get weightSum {
    double weightSum = 0;

    for (var item in foodItems) {
      if (!item.hasWeight || item.excludedFromCalculations) continue;

      weightSum += item.servingWeight;
    }

    return weightSum;
  }

  double get proteinSum {
    double proteinSum = 0;

    for (var item in foodItems) {
      if (!item.hasWeight || item.excludedFromCalculations) continue;

      proteinSum += item.servingProtein;
    }

    return proteinSum;
  }

  double get carbsSum {
    double carbsSum = 0;

    for (var item in foodItems) {
      if (!item.hasWeight || item.excludedFromCalculations) continue;

      carbsSum += item.servingCarbs;
    }

    return carbsSum;
  }

  double get calorieDensityValue {
    final result = caloriesSum / weightSum;

    return result.isNaN || result.isInfinite ? 0 : result;
  }

  double get proteinDegreeValue {
    final result = (((proteinSum * 4) / caloriesSum) * 100);
    return (result.isNaN || result.isInfinite) ? 0 : result;
  }

  double get carbFiberRatio {
    final result = carbsSum / fiberSum;

    return (result.isNaN || result.isInfinite) ? 0 : result;
  }

  double get carbsPercent {
    final result = ((carbsSum * 4) / caloriesSum) * 100;

    return (result.isNaN || result.isInfinite) ? 0 : result;
  }

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
}
