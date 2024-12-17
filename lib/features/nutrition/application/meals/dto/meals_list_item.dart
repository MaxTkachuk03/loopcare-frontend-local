import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

part 'meals_list_item.freezed.dart';

part 'meals_list_item.g.dart';

@freezed
class MealsListItem with _$MealsListItem {
  const MealsListItem._();

  const factory MealsListItem({
    required int id,
    required List<MealItem> mealItems,
    required DateTime? loggingDate,
    required String mealCategory,
    required double calorieDensity,
    required double proteinDegree,
    required ServingSize serving,
    required DateTime createdAt,
    required DateTime updatedAt,
    List<DateTime>? planningDates,
  }) = _MealItem;

  get order {
    if (mealCategory == MealCategory.breakfast.originalValue) return 1;
    if (mealCategory == MealCategory.lunch.originalValue) return 2;
    if (mealCategory == MealCategory.dinner.originalValue) return 3;
    if (mealCategory == MealCategory.inbetweens.originalValue) return 4;
    // if (mealCategory == MealCategory.drinks.originalValue) return 5;
    return 0;
  }

  double get caloriesSum {
    double caloriesSum = 0;

    for (var mealItem in mealItems) {
      if (!mealItem.hasWeight || mealItem.excludedFromCalculations) continue;

      caloriesSum += mealItem.servingCalories;
    }

    return caloriesSum;
  }

  double get caloriesSumWithDrinks {
    double caloriesSum = 0;

    for (var mealItem in mealItems) {
      caloriesSum += mealItem.servingCalories;
    }

    return caloriesSum;
  }

  double get fiberSum {
    double fiberSum = 0;

    for (var mealItem in mealItems) {
      if (!mealItem.hasWeight || mealItem.excludedFromCalculations) continue;

      fiberSum += mealItem.servingFiber;
    }

    return fiberSum;
  }

  double get carbohydratesSum {
    double carbohydratesSum = 0;

    for (var mealItem in mealItems) {
      if (!mealItem.hasWeight || mealItem.excludedFromCalculations) continue;

      carbohydratesSum += mealItem.servingCarbs;
    }

    return carbohydratesSum;
  }

  double get weightSum {
    double weightSum = 0;

    for (var mealItem in mealItems) {
      if (!mealItem.hasWeight || mealItem.excludedFromCalculations) continue;

      weightSum += mealItem.servingWeight;
    }

    return weightSum;
  }

  double get proteinSum {
    double proteinSum = 0;

    for (var mealItem in mealItems) {
      if (!mealItem.hasWeight || mealItem.excludedFromCalculations) continue;

      proteinSum += mealItem.servingProtein;
    }

    return proteinSum;
  }

  factory MealsListItem.fromJson(Map<String, dynamic> json) => _$MealsListItemFromJson(json);

  factory MealsListItem.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing MealsListItem: $json');

      // Parse and validate each field
      final id = json['id'] as int? ?? 0;
      log.d('Parsed id: $id');

      final rawMealItems = json['mealItems'] as List<dynamic>? ?? [];
      log.d('Raw mealItems: $rawMealItems');
      final mealItems =
          rawMealItems.map((e) => MealItem.debugFromJson(e as Map<String, dynamic>)).toList();
      log.d('Parsed mealItems: $mealItems');

      final loggingDate =
          json['loggingDate'] != null ? DateTime.tryParse(json['loggingDate'] as String) : null;
      log.d('Parsed loggingDate: $loggingDate');

      final mealCategory = json['mealCategory'] as String? ?? '';
      log.d('Parsed mealCategory: $mealCategory');

      final calorieDensity = (json['calorieDensity'] as num?)?.toDouble() ?? 0.0;
      log.d('Parsed calorieDensity: $calorieDensity');

      final proteinDegree = (json['proteinDegree'] as num?)?.toDouble() ?? 0.0;
      log.d('Parsed proteinDegree: $proteinDegree');

      final serving = json['serving'] != null
          ? ServingSize.fromJson(json['serving'] as Map<String, dynamic>)
          : throw Exception('Missing "serving" field');
      log.d('Parsed serving: $serving');

      final createdAt = DateTime.parse(json['createdAt'] as String);
      log.d('Parsed createdAt: $createdAt');

      final updatedAt = DateTime.parse(json['updatedAt'] as String);
      log.d('Parsed updatedAt: $updatedAt');

      final rawPlanningDates = json['planningDates'] as List<dynamic>? ?? [];
      log.d('Raw planningDates: $rawPlanningDates');
      final planningDates = rawPlanningDates
          .map((e) => DateTime.tryParse(e as String))
          .where((e) => e != null)
          .cast<DateTime>()
          .toList();
      log.d('Parsed planningDates: $planningDates');

      return MealsListItem(
        id: id,
        mealItems: mealItems,
        loggingDate: loggingDate,
        mealCategory: mealCategory,
        calorieDensity: calorieDensity,
        proteinDegree: proteinDegree,
        serving: serving,
        createdAt: createdAt,
        updatedAt: updatedAt,
        planningDates: planningDates,
      );
    } catch (e, stackTrace) {
      log.e('Error in MealsListItem.debugFromJson: $e');
      log.e('Stack Trace: $stackTrace');
      log.e('Problematic JSON: $json');
      rethrow;
    }
  }
}
