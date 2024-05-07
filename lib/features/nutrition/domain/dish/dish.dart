import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_utils.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'dish.freezed.dart';

part 'dish.g.dart';

@freezed
class Dish with _$Dish, NutritionUtils {
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

  double get _servings => serving.numberOfUnits;

  double sumNutritionalProperty(double Function(DishFoodItem item) getProperty) {
    double sum = 0;

    for (var item in foodItems) {
      if (!item.hasWeight || item.excludedFromCalculations) continue;

      sum += getProperty(item);
    }

    return sum;
  }

  double get caloriesSumWithDrinks =>
      foodItems.fold<double>(0.0, (sum, i) => sum + (i.hasWeight ? i.servingCalories : 0.0));

  double get caloriesSum => sumNutritionalProperty((item) => item.servingCalories);

  double get fiberSum => sumNutritionalProperty((item) => item.servingFiber) * _servings;

  double get carbohydratesSum => sumNutritionalProperty((item) => item.servingCarbs);

  double get weightSum => sumNutritionalProperty((item) => item.servingWeight);

  double get proteinSum => sumNutritionalProperty((item) => item.servingProtein);

  double get carbsSum => sumNutritionalProperty((item) => item.servingCarbs);

  double get calorieDensityValue => getCalorieDensity(caloriesSum, weightSum);

  double get proteinDegreeValue => getProteinDegree(proteinSum, caloriesSum);

  double get carbFiberRatio => getCarbFiberRatio(carbsSum, fiberSum);

  double get carbsPercent => getCarbsPercent(carbsSum, caloriesSum);

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
}
