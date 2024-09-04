part of 'meals_bloc.dart';

@freezed
class MealsState with _$MealsState {
  const factory MealsState.initial(MealsStateData data) = MealsStateInitial;

  const factory MealsState.loading(MealsStateData data) = MealsStateLoading;

  const factory MealsState.error(MealsStateData data) = MealsStateError;

  const factory MealsState.mealsInfo(MealsStateData data) = MealsStateLoaded;
}

@freezed
class MealsStateData with _$MealsStateData, NutritionUtils {
  const MealsStateData._();

  const factory MealsStateData({
    int? currentMealId,
    @Default(NutritionValuesTypes.calories) NutritionValuesTypes currentNutritionType,
    @Default({}) Map<String, List<MealsListItem>> meals,
    @Default(false) bool isLoading,
    DateTime? currentDate,
    String? currentMealCategory,
    DateTime? timeStamp,
    ServingSize? selectedServing,
    RequestError? error,
  }) = _MealsStateData;

  DateTime get currentDateTime => currentDate ?? DateTime.now();

  bool get isEditable => currentDateTime.isAfter(DateTime.now().subtract(const Duration(days: 8)));

  double get selectedDayMealCalorieDensitySum {
    if (meals.isEmpty) return 0;

    double caloriesSum = 0;
    double weight = 0;

    final selectedDayMeals = meals[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    for (MealsListItem meal in selectedDayMeals) {
      if (meal.loggingDate?.isSameDate(currentDateTime) ?? false) {
        caloriesSum += meal.caloriesSum;
        weight += meal.weightSum;
      }
    }

    return getCalorieDensity(caloriesSum, weight);
  }

  double get selectedDayMealFiber {
    if (meals.isEmpty) return 0;

    double fiberSum = 0;

    final selectedDayMeals = meals[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    for (MealsListItem meal in selectedDayMeals) {
      if (meal.loggingDate?.isSameDate(currentDateTime) ?? false) {
        fiberSum += meal.fiberSum;
      }
    }

    return fiberSum;
  }

  double get selectedDayMealCarbFiberRatio {
    if (meals.isEmpty) return 0;

    double fiberSum = 0;
    double carbsSum = 0;

    final selectedDayMeals = meals[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    for (MealsListItem meal in selectedDayMeals) {
      if (meal.loggingDate?.isSameDate(currentDateTime) ?? false) {
        fiberSum += meal.fiberSum;
        carbsSum += meal.carbohydratesSum;
      }
    }

    return getCarbFiberRatio(carbsSum, fiberSum);
  }

  double get carbsPercent {
    if (meals.isEmpty) return 0;

    double calorieSum = 0;
    double carbsSum = 0;

    final selectedDayMeals = meals[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    for (MealsListItem meal in selectedDayMeals) {
      if (meal.loggingDate?.isSameDate(currentDateTime) ?? false) {
        calorieSum += meal.caloriesSum;
        carbsSum += meal.carbohydratesSum;
      }
    }

    return getCarbsPercent(carbsSum, calorieSum);
  }

  double get selectedDayMealTotalCarbs {
    if (meals.isEmpty) return 0;

    double carbsSum = 0;

    final selectedDayMeals = meals[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    for (MealsListItem meal in selectedDayMeals) {
      if (meal.loggingDate?.isSameDate(currentDateTime) ?? false) {
        carbsSum += meal.carbohydratesSum;
      }
    }

    return carbsSum;
  }

  double get selectedDayMealCarbsPercent {
    if (meals.isEmpty) return 0;

    double carbsSum = 0;
    double calorieSum = 0;

    final selectedDayMeals = meals[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    for (MealsListItem meal in selectedDayMeals) {
      if (meal.loggingDate?.isSameDate(currentDateTime) ?? false) {
        carbsSum += meal.carbohydratesSum;
        calorieSum += meal.caloriesSum;
      }
    }

    return getCarbsPercent(carbsSum, calorieSum);
  }

  double get selectedDayMealTotalCaloriesWithDrinks {
    if (meals.isEmpty) return 0;

    double calorieSum = 0;

    final selectedDayMeals = meals[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    for (MealsListItem meal in selectedDayMeals) {
      if (meal.loggingDate?.isSameDate(currentDateTime) ?? false) {
        calorieSum += meal.caloriesSumWithDrinks;
      }
    }

    return calorieSum;
  }

  double get selectedDayMealProteinDegreeSum {
    if (meals.isEmpty) return 0;

    double caloriesSum = 0;
    double proteinSum = 0;

    final selectedDayMeals = meals[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    for (var meal in selectedDayMeals) {
      if (meal.loggingDate?.isSameDate(currentDateTime) ?? false) {
        caloriesSum += meal.caloriesSum;
        proteinSum += meal.proteinSum;
      }
    }

    return getProteinDegree(proteinSum, caloriesSum);
  }

  List<String> get filledCategories {
    if (meals.isEmpty) return <String>[];

    final selectedDayMeals = meals[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    return selectedDayMeals
        .where((item) => item.mealItems.isNotEmpty)
        .toList()
        .map((e) => categoryShortVersion(e.mealCategory))
        .toList()
        .toSet()
        .toList();
  }

  String categoryShortVersion(String category) =>
      category.toLowerCase() == MealCategory.inbetweens.originalValue
          ? MealCategory.inbetweens.name
          : category;

  int? get getCurrentMealId => currentMealId;

  MealsListItem? get currentMeal =>
      mealsMap[currentDate?.isoStringWithoutTime]?.firstWhereOrNull((el) => el.id == currentMealId);

  String? get mealListLength => mealsMap.length.toString();

  List<DateTime>? get currentMealDates => [currentDateTime];

  String? get selectedMealCategory => currentMealCategory?.capitalizeOnlyFirstLetter();

  Map<String, List<MealsListItem>> get mealsMap => meals;

  ServingSize? get currentMealServing {
    if (mealsMap.isEmpty || currentMealCategory == null) {
      return null;
    }

    final selectedDayMeals = mealsMap[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    return selectedDayMeals.firstWhere((item) => item.mealCategory == currentMealCategory).serving;
  }

  List<MealItem> get currentFoodItems {
    if (mealsMap.isEmpty || currentMealId == null) {
      return <MealItem>[];
    }

    final selectedDayMeals = mealsMap[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    final MealsListItem? currentMeal = selectedDayMeals.firstWhereOrNull((item) => item.id == currentMealId);

    if (currentMeal == null) {
      return <MealItem>[];
    }

    return currentMeal.mealItems.toList();
  }

  bool get isContainsRecipeOrDish {
    if (meals.isEmpty || currentMealId == null) {
      return false;
    }

    final MealsListItem? currentMeal =
        meals[currentDate?.isoStringWithoutTime]?.firstWhereOrNull((item) => item.id == currentMealId);

    if (currentMeal == null) return false;

    return currentMeal.mealItems.any((e) => e.type == MealItemType.recipe || e.type == MealItemType.dish);
  }

  double get currentMealProteinDegree {
    if (mealsMap.isEmpty || currentMealId == null) {
      return 0;
    }

    final selectedDayMeals = mealsMap[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    final MealsListItem? currentMeal = selectedDayMeals.firstWhereOrNull((item) => item.id == currentMealId);

    if (currentMeal == null) return 0;

    return getProteinDegree(currentMeal.proteinSum, currentMeal.caloriesSum);
  }

  double get currentMealCalorieDensity {
    if (mealsMap.isEmpty || currentMealId == null) {
      return 0;
    }

    final selectedDayMeals = mealsMap[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    final MealsListItem? currentMeal = selectedDayMeals.firstWhereOrNull((item) => item.id == currentMealId);

    if (currentMeal == null) return 0;

    return getCalorieDensity(currentMeal.caloriesSum, currentMeal.weightSum);
  }

  double get currentMealFiber {
    if (mealsMap.isEmpty || currentMealId == null) {
      return 0;
    }

    final selectedDayMeals = mealsMap[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    final MealsListItem? currentMeal = selectedDayMeals.firstWhereOrNull((item) => item.id == currentMealId);

    if (currentMeal == null) return 0;

    return currentMeal.fiberSum;
  }

  double get currentMealCarbFiberRatio {
    if (mealsMap.isEmpty || currentMealId == null) {
      return 0;
    }

    final selectedDayMeals = mealsMap[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    final MealsListItem? currentMeal = selectedDayMeals.firstWhereOrNull((item) => item.id == currentMealId);

    if (currentMeal == null) return 0;

    return getCarbFiberRatio(currentMeal.carbohydratesSum, currentMeal.fiberSum);
  }

  double get currentMealCarbsPercent {
    if (mealsMap.isEmpty || currentMealId == null) {
      return 0;
    }

    final selectedDayMeals = mealsMap[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    final MealsListItem? currentMeal = selectedDayMeals.firstWhereOrNull((item) => item.id == currentMealId);

    if (currentMeal == null) return 0;

    return getCarbsPercent(currentMeal.carbohydratesSum, currentMeal.caloriesSum);
  }

  double get currentMealCalories {
    if (mealsMap.isEmpty || currentMealId == null) {
      return 0;
    }

    final selectedDayMeals = mealsMap[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    final MealsListItem? currentMeal = selectedDayMeals.firstWhereOrNull((item) => item.id == currentMealId);

    if (currentMeal == null) return 0;

    return currentMeal.caloriesSumWithDrinks;
  }

  double get currentMealCarbsSum {
    if (mealsMap.isEmpty || currentMealId == null) {
      return 0;
    }

    final selectedDayMeals = mealsMap[currentDateTime.isoStringWithoutTime] ?? <MealsListItem>[];

    final MealsListItem? currentMeal = selectedDayMeals.firstWhereOrNull((item) => item.id == currentMealId);

    if (currentMeal == null) return 0;

    return currentMeal.carbohydratesSum;
  }

  double calorieDensitySum(List<MealItem> selectedDayMeals) {
    double caloriesSum = 0;
    double amountSum = 0;

    for (var meal in selectedDayMeals) {
      caloriesSum += meal.servingCalories;
      amountSum += meal.servingWeight;
    }

    return getCalorieDensity(caloriesSum, amountSum);
  }
}
