part of 'meals_bloc.dart';

@freezed
class MealsState with _$MealsState, NutritionUtils {
  const MealsState._();

  const factory MealsState.initial() = _Initial;

  const factory MealsState.loading() = _Loading;

//TODO: old state style
  const factory MealsState.error(RequestError fetchError) = _Error;

  const factory MealsState.mealsInfo({
    int? currentMealId,
    @Default(NutritionValuesTypes.calories) NutritionValuesTypes currentNutritionType,
    @Default(MealActionModes.mealLogging) MealActionModes mealActionMode,
    @Default(false) bool isLoading,
    RequestError? error,
    DateTime? currentDate,
    DateTime? originCurrentDate,
    String? currentMealCategory,
    required Map<String, List<MealsListItem>> meals,
    required Map<String, List<MealsListItem>> plannedMeals,
    DateTime? timeStamp,
    ServingSize? selectedServing,
  }) = _MealsInfo;

  List<MealsListItem> get plannedMealsForCurrentDate {
    return maybeMap(
        mealsInfo: (s) => s.plannedMeals[getCurrentDate.isoStringWithoutTime] ?? [], orElse: () => []);
  }

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

  DateTime get getOriginDate {
    return maybeMap(
      mealsInfo: (s) => s.originCurrentDate ?? DateTime.now(),
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
      mealsInfo: (s) => s.currentDate?.isAfter(DateTime.now().subtract(const Duration(days: 8))) ?? false,
      orElse: () => false,
    );
  }

  bool get isPossibleToPlanMeal {
    return maybeMap(
      mealsInfo: (s) {
        var currentDate = s.currentDate;
        if (currentDate != null) {
          final maxDate = DateTime.now().add(const Duration(days: 14));
          final isAfter = (currentDate.isToday) || currentDate.isAfter(DateTime.now().midnightTime);
          final isBefore = currentDate.isBefore(maxDate);

          return isAfter && isBefore;
        } else {
          return false;
        }
      },
      orElse: () => false,
    );
  }

  bool get isNeededToFetchMeal {
    return maybeMap(
      mealsInfo: (s) {
        return isPossibleToPlanMeal || isEnableOnDashboard;
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
      double weight = 0;

      final selectedDayMeals = state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

      for (MealsListItem meal in selectedDayMeals) {
        if (meal.loggingDate?.isSameDate(currentDate) ?? false) {
          caloriesSum += meal.caloriesSum;
          weight += meal.weightSum;
        }
      }

      return getCalorieDensity(caloriesSum, weight);
    });
  }

  double? get selectedDayMealFiber {
    return mapOrNull(mealsInfo: (state) {
      final currentDate = state.currentDate;

      if (state.meals.isEmpty || currentDate == null) {
        return null;
      }

      double fiberSum = 0;

      final selectedDayMeals = state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

      for (MealsListItem meal in selectedDayMeals) {
        if (meal.loggingDate?.isSameDate(currentDate) ?? false) {
          fiberSum += meal.fiberSum;
        }
      }

      return fiberSum;
    });
  }

  double? get selectedDayMealCarbFiberRatio {
    return mapOrNull(mealsInfo: (state) {
      final currentDate = state.currentDate;

      if (state.meals.isEmpty || currentDate == null) {
        return null;
      }

      double fiberSum = 0;
      double carbsSum = 0;

      final selectedDayMeals = state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

      for (MealsListItem meal in selectedDayMeals) {
        if (meal.loggingDate?.isSameDate(currentDate) ?? false) {
          fiberSum += meal.fiberSum;
          carbsSum += meal.carbohydratesSum;
        }
      }

      return getCarbFiberRatio(carbsSum, fiberSum);
    });
  }

  double? get carbsPercent {
    return mapOrNull(mealsInfo: (state) {
      final currentDate = state.currentDate;

      if (state.meals.isEmpty || currentDate == null) {
        return null;
      }

      double calorieSum = 0;
      double carbsSum = 0;

      final selectedDayMeals = state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

      for (MealsListItem meal in selectedDayMeals) {
        if (meal.loggingDate?.isSameDate(currentDate) ?? false) {
          calorieSum += meal.caloriesSum;
          carbsSum += meal.carbohydratesSum;
        }
      }

      return getCarbsPercent(carbsSum, calorieSum);
    });
  }

  double? get selectedDayMealTotalCarbs {
    return mapOrNull(mealsInfo: (state) {
      final currentDate = state.currentDate;

      if (state.meals.isEmpty || currentDate == null) {
        return null;
      }

      double carbsSum = 0;

      final selectedDayMeals = state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

      for (MealsListItem meal in selectedDayMeals) {
        if (meal.loggingDate?.isSameDate(currentDate) ?? false) {
          carbsSum += meal.carbohydratesSum;
        }
      }

      return carbsSum;
    });
  }

  double? get selectedDayMealCarbsPercent {
    return mapOrNull(mealsInfo: (state) {
      final currentDate = state.currentDate;

      if (state.meals.isEmpty || currentDate == null) {
        return null;
      }

      double carbsSum = 0;
      double calorieSum = 0;

      final selectedDayMeals = state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

      for (MealsListItem meal in selectedDayMeals) {
        if (meal.loggingDate?.isSameDate(currentDate) ?? false) {
          carbsSum += meal.carbohydratesSum;
          calorieSum += meal.caloriesSum;
        }
      }

      return getCarbsPercent(carbsSum, calorieSum);
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

        final selectedDayMeals = state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        for (var meal in selectedDayMeals) {
          if (meal.loggingDate?.isSameDate(currentDate) ?? false) {
            caloriesSum += meal.caloriesSum;
            proteinSum += meal.proteinSum;
          }
        }

        return getProteinDegree(proteinSum, caloriesSum);
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
        final selectedDayMeals = state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        return selectedDayMeals
            .where((item) => item.mealItems.isNotEmpty)
            .toList()
            .map((e) => categoryShortVersion(e.mealCategory))
            .toList()
            .toSet()
            .toList();
      },
      orElse: () => <String>[],
    );
  }

  String categoryShortVersion(String category) {
    return category.toLowerCase() == MealCategory.inbetweens.originalValue
        ? MealCategory.inbetweens.shortValue
        : category;
  }

  List<String> get filledPlannedMealCategories {
    return maybeMap(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (state.plannedMeals.isEmpty || currentDate == null) {
          return <String>[];
        }
        final selectedDayMeals = state.plannedMeals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        return selectedDayMeals
            .where((item) => item.mealItems.isNotEmpty)
            .toList()
            .map((e) => categoryShortVersion(e.mealCategory))
            .toList()
            .toSet()
            .toList();
      },
      orElse: () => <String>[],
    );
  }

  List<String> get filledPlannedMealDates {
    return maybeMap(
      mealsInfo: (state) {
        if (state.plannedMeals.isEmpty) {
          return <String>[];
        }

        return state.plannedMeals.keys.toList();
      },
      orElse: () => <String>[],
    );
  }

  int? get getCurrentMealId {
    return mapOrNull(
      mealsInfo: (state) => state.currentMealId,
    );
  }

  MealsListItem? get currentMeal {
    return mapOrNull(
      mealsInfo: (state) {
        return state.mealsMap[state.currentDate?.isoStringWithoutTime]
            ?.firstWhereOrNull((el) => el.id == state.currentMealId);
      },
    );
  }

  MealsListItem? get plannedMealByCurrentId {
    return mapOrNull(
      mealsInfo: (state) {
        var retItem;
        if (state.plannedMeals.isNotEmpty) {
          state.plannedMeals.forEach(
            (key, value) {
              if (value.isNotEmpty) {
                for (var element in value) {
                  if (element.id == getCurrentMealId) {
                    retItem = element;
                  }
                }
              }
            },
          );
        }

        return retItem;
      },
    );
  }

  String? get mealListLength {
    return mapOrNull(
      mealsInfo: (state) =>
          state.isPlanningMeals ? state.plannedMeals.length.toString() : mealsMap.length.toString(),
    );
  }

  List<DateTime>? get currentMealDates {
    return maybeMap(
      mealsInfo: (s) => isPlanningMeals ? s.currentMeal?.planningDates! : [getCurrentDate],
      orElse: () => [getCurrentDate],
    );
  }

  String? get currentMealCategory {
    return mapOrNull(
      mealsInfo: (state) => state.currentMealCategory?.capitalizeOnlyFirstLetter(),
    );
  }

  Map<String, List<MealsListItem>> get mealsMap {
    return maybeMap(
      mealsInfo: (s) {
        return isPlanningMeals ? s.plannedMeals : s.meals;
      },
      orElse: () => {},
    );
  }

  ServingSize? get currentMealServing {
    return mapOrNull(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (mealsMap.isEmpty || state.currentMealCategory == null || currentDate == null) {
          return null;
        }
        final selectedDayMeals = mealsMap[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

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
        if (mealsMap.isEmpty || state.currentMealId == null || currentDate == null) {
          return <MealItem>[];
        }
        final selectedDayMeals = mealsMap[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final MealsListItem? currentMeal = selectedDayMeals.firstWhereOrNull(
          (item) => item.id == state.currentMealId,
        );

        if (currentMeal == null) {
          return <MealItem>[];
        }

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

        final MealsListItem? currentMeal = state.meals[state.currentDate?.isoStringWithoutTime]
            ?.firstWhereOrNull((item) => item.id == state.currentMealId);

        if (currentMeal == null) return false;

        return currentMeal.mealItems.any((e) => e.type == 'recipe' || e.type == 'dish');
      },
      orElse: () => false,
    );
  }

  double? get currentMealProteinDegree {
    return mapOrNull(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (mealsMap.isEmpty || state.currentMealId == null || currentDate == null) {
          return null;
        }
        final selectedDayMeals = mealsMap[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final MealsListItem? currentMeal =
            selectedDayMeals.firstWhereOrNull((item) => item.id == state.currentMealId);

        if (currentMeal == null) return null;

        return getProteinDegree(currentMeal.proteinSum, currentMeal.caloriesSum);
      },
    );
  }

  double? get currentMealCalorieDensity {
    return mapOrNull(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (mealsMap.isEmpty || state.currentMealId == null || currentDate == null) {
          return null;
        }

        final selectedDayMeals = mealsMap[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final MealsListItem? currentMeal =
            selectedDayMeals.firstWhereOrNull((item) => item.id == state.currentMealId);

        if (currentMeal == null) return null;

        return getCalorieDensity(currentMeal.caloriesSum, currentMeal.weightSum);
      },
    );
  }

  double? get currentMealFiber {
    return mapOrNull(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (mealsMap.isEmpty || state.currentMealId == null || currentDate == null) {
          return null;
        }

        final selectedDayMeals = mealsMap[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final MealsListItem? currentMeal =
            selectedDayMeals.firstWhereOrNull((item) => item.id == state.currentMealId);

        if (currentMeal == null) return null;

        return currentMeal.fiberSum;
      },
    );
  }

  double? get currentMealCarbFiberRatio {
    return mapOrNull(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (mealsMap.isEmpty || state.currentMealId == null || currentDate == null) {
          return null;
        }

        final selectedDayMeals = mealsMap[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final MealsListItem? currentMeal =
            selectedDayMeals.firstWhereOrNull((item) => item.id == state.currentMealId);

        if (currentMeal == null) return null;

        return getCarbFiberRatio(currentMeal.carbohydratesSum, currentMeal.fiberSum);
      },
    );
  }

  double? get currentMealCarbsPercent {
    return mapOrNull(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (mealsMap.isEmpty || state.currentMealId == null || currentDate == null) {
          return null;
        }

        final selectedDayMeals = mealsMap[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final MealsListItem? currentMeal =
            selectedDayMeals.firstWhereOrNull((item) => item.id == state.currentMealId);

        if (currentMeal == null) return null;

        return getCarbsPercent(currentMeal.carbohydratesSum, currentMeal.caloriesSum);
      },
    );
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

  List<MealsListItem> get todaysLoggedPlannedMeals {
    return maybeMap(
        mealsInfo: (s) =>
            s.plannedMeals[s.currentDate?.isoStringWithoutTime]
                ?.where((element) => element.mealItems.isNotEmpty)
                .toList() ??
            <MealsListItem>[],
        orElse: () => <MealsListItem>[]);
  }
}
