part of 'meals_bloc.dart';

@freezed
class MealsState with _$MealsState {
  const MealsState._();

  const factory MealsState.initial() = _Initial;

  const factory MealsState.loading() = _Loading;

  const factory MealsState.error(RequestError fetchError) = _Error;

  const factory MealsState.mealsInfo({
    int? currentMealId,
    MealsListItem? currentMeal,
    NutritionItem? currentNutritionItem,
    @Default(MealActionModes.mealLogging) MealActionModes mealActionMode,
    DateTime? currentDate,
    String? currentMealCategory,
    required Map<String, List<MealsListItem>> meals,
    required Map<String, List<MealsListItem>> plannedMeals,
    ServingSize? selectedServing,
  }) = _MealsInfo;

  bool get isPlanningMeals {
    return maybeMap(
      mealsInfo: (s) {
        return s.mealActionMode == MealActionModes.mealPlanning;
      },
      orElse: () => false,
    );
  }

  DateTime get getCurrentDate {
    return maybeMap(
      mealsInfo: (s) => s.currentDate ?? DateTime.now(),
      orElse: () => DateTime.now(),
    );
  }

  bool get isNeedToHideOnDashboard {
    return maybeMap(
      mealsInfo: (s) => s.currentDate?.isAfter(DateTime.now()) ?? false,
      orElse: () => false,
    );
  }

  bool get isEnableOnDashboard {
    return maybeMap(
      mealsInfo: (s) =>
          s.currentDate
              ?.isAfter(DateTime.now().subtract(const Duration(days: 8))) ??
          false,
      orElse: () => false,
    );
  }

  bool get isPossibleToPlanMeal {
    return maybeMap(
      mealsInfo: (s) {
        final maxDate = DateTime.now().add(const Duration(days: 14));
        final isAfter = s.currentDate?.isAfter(DateTime.now()) ?? false;
        final isBefore = s.currentDate?.isBefore(maxDate) ?? false;

        return isAfter && isBefore;
      },
      orElse: () => false,
    );
  }

  double? get selectedDayMealCalorieDensitySum {
    return mapOrNull(mealsInfo: (state) {
      final currentDate = state.currentDate;

      if (state.meals.isEmpty || currentDate == null) {
        return null;
      }

      double caloriesSum = 0;
      double amountSum = 0;

      final selectedDayMeals =
          state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

      for (var meal in selectedDayMeals) {
        if (meal.loggingDate?.isSameDate(currentDate) ?? false) {
          caloriesSum += meal.serving.calories;
          amountSum += meal.serving.metricServingAmount ?? 1;
        }
      }

      final result = caloriesSum / amountSum;
      return result.isNaN || result.isInfinite ? null : result;
    });
  }

  double? get selectedDayMealProteinDegreeSum {
    return mapOrNull(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (state.meals.isEmpty || currentDate == null) {
          return null;
        }

        double caloriesSum = 0;
        double proteinSum = 0;

        final selectedDayMeals =
            state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        for (var meal in selectedDayMeals) {
          if (meal.loggingDate?.isSameDate(currentDate) ?? false) {
            caloriesSum += meal.serving.calories;
            proteinSum += meal.serving.protein;
          }
        }

        final result = (((proteinSum * 4) / caloriesSum) * 100);
        return (result.isNaN || result.isInfinite) ? null : result;
      },
    );
  }

  List<String> get filledCategories {
    return maybeMap(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (state.meals.isEmpty || currentDate == null) {
          return <String>[];
        }
        final selectedDayMeals =
            state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        return selectedDayMeals
            .where((item) => item.mealItems.isNotEmpty)
            .toList()
            .map((e) => e.mealCategory)
            .toList()
            .toSet()
            .toList();
      },
      orElse: () => <String>[],
    );
  }

  List<String> get filledPlannedMealCategories {
    return maybeMap(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (state.plannedMeals.isEmpty || currentDate == null) {
          return <String>[];
        }
        final selectedDayMeals =
            state.plannedMeals[currentDate.isoStringWithoutTime] ??
                <MealsListItem>[];

        return selectedDayMeals
            .where((item) => item.mealItems.isNotEmpty)
            .toList()
            .map((e) => e.mealCategory)
            .toList()
            .toSet()
            .toList();
      },
      orElse: () => <String>[],
    );
  }

  int? get getCurrentMealId {
    return mapOrNull(
      mealsInfo: (state) => state.currentMealId,
    );
  }

  String? get mealListLength {
    return mapOrNull(
      mealsInfo: (state) => state.isPlanningMeals
          ? state.plannedMeals.length.toString()
          : mealsMap.length.toString(),
    );
  }

  String? get currentMealCategory {
    return mapOrNull(
      mealsInfo: (state) =>
          state.currentMealCategory?.capitalizeOnlyFirstLetter(),
    );
  }

  Map<String, List<MealsListItem>> get mealsMap {
    return maybeMap(
      mealsInfo: (s) => isPlanningMeals ? s.plannedMeals : s.meals,
      orElse: () => {},
    );
  }

  ServingSize? get currentMealServing {
    return mapOrNull(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (mealsMap.isEmpty ||
            state.currentMealCategory == null ||
            currentDate == null) {
          return null;
        }
        final selectedDayMeals =
            mealsMap[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        return selectedDayMeals
            .firstWhere(
              (item) => item.mealCategory == state.currentMealCategory,
            )
            .serving;
      },
    );
  }

  List<MealItem> get currentFoodItems {
    return maybeMap(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (mealsMap.isEmpty ||
            state.currentMealId == null ||
            currentDate == null) {
          return <MealItem>[];
        }
        final selectedDayMeals =
            mealsMap[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final MealsListItem? currentMeal = selectedDayMeals.firstWhereOrNull(
          (item) => item.id == state.currentMealId,
        );

        if (currentMeal == null) return <MealItem>[];

        return currentMeal.mealItems.toList();
      },
      orElse: () => <MealItem>[],
    );
  }

  bool get isContainsRecipeOrDish {
    return maybeMap(
      mealsInfo: (state) {
        if (state.meals.isEmpty || state.currentMealId == null) {
          return false;
        }

        final MealsListItem? currentMeal = state.meals[state.currentDate]
            ?.firstWhereOrNull((item) => item.id == state.currentMealId);

        if (currentMeal == null) return false;

        return currentMeal.mealItems
            .any((e) => e.type == 'recipe' || e.type == 'dish');
      },
      orElse: () => false,
    );
  }

  double? get currentMealProteinDegree {
    return mapOrNull(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (mealsMap.isEmpty ||
            state.currentMealId == null ||
            currentDate == null) {
          return null;
        }
        final selectedDayMeals =
            mealsMap[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final MealsListItem? currentMeal = selectedDayMeals
            .firstWhereOrNull((item) => item.id == state.currentMealId);

        if (currentMeal == null) return null;

        return currentMeal.proteinDegree;
      },
    );
  }

  double? get currentMealCalorieDensity {
    return mapOrNull(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (mealsMap.isEmpty ||
            state.currentMealId == null ||
            currentDate == null) {
          return null;
        }

        final selectedDayMeals =
            mealsMap[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final MealsListItem? currentMeal = selectedDayMeals
            .firstWhereOrNull((item) => item.id == state.currentMealId);

        if (currentMeal == null) return null;

        return currentMeal.calorieDensity;
      },
    );
  }
}
