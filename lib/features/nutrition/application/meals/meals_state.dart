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
    DateTime? currentDate,
    String? currentMealCategory,
    required Map<String, List<MealsListItem>> meals,
    ServingSize? selectedServing,
  }) = _MealsInfo;

  DateTime get getCurrentDate {
    return maybeWhen(
      mealsInfo: (
        currentMealId,
        currentMeal,
        currentNutritionItem,
        currentDate,
        currentMealCategory,
        meals,
        selectedServing,
      ) =>
          currentDate ?? DateTime.now(),
      orElse: () => DateTime.now(),
    );
  }

  bool get isNeedToHideOnDashboard {
    return maybeWhen(
      mealsInfo: (
        currentMealId,
        currentMeal,
        currentNutritionItem,
        currentDate,
        currentMealCategory,
        meals,
        selectedServing,
      ) =>
          currentDate?.isAfter(DateTime.now()) ?? false,
      orElse: () => false,
    );
  }

  bool get isEnableOnDashboard {
    return maybeWhen(
      mealsInfo: (
        currentMealId,
        currentMeal,
        currentNutritionItem,
        currentDate,
        currentMealCategory,
        meals,
        selectedServing,
      ) =>
          currentDate
              ?.isAfter(DateTime.now().subtract(const Duration(days: 8))) ??
          false,
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
        if (meal.loggingDate.isSameDate(currentDate)) {
          caloriesSum += meal.serving.calories;
          amountSum += meal.serving.metricServingAmount ?? 1;
        }
      }

      final result = caloriesSum / amountSum;
      return result.isNaN ? null : result;
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
          if (meal.loggingDate.isSameDate(currentDate)) {
            caloriesSum += meal.serving.calories;
            proteinSum += meal.serving.protein;
          }
        }

        final result = (((proteinSum * 4) / caloriesSum) * 100);
        return result.isNaN ? null : result;
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

  int? get getCurrentMealId {
    return mapOrNull(
      mealsInfo: (state) => state.currentMealId,
    );
  }

  String? get mealListLength {
    return mapOrNull(
      mealsInfo: (state) => state.meals.length.toString(),
    );
  }

  String? get currentMealCategory {
    return mapOrNull(
      mealsInfo: (state) =>
          state.currentMealCategory?.capitalizeOnlyFirstLetter(),
    );
  }

  ServingSize? get currentMealServing {
    return mapOrNull(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (state.meals.isEmpty ||
            state.currentMealCategory == null ||
            currentDate == null) {
          return null;
        }
        final selectedDayMeals =
            state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

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
        if (state.meals.isEmpty ||
            state.currentMealId == null ||
            currentDate == null) {
          return <MealItem>[];
        }
        final selectedDayMeals =
            state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final MealsListItem? currentMeal = selectedDayMeals.firstWhereOrNull(
          (item) => item.id == state.currentMealId,
        );

        if (currentMeal == null) return <MealItem>[];

        return currentMeal.mealItems.toList();
      },
      orElse: () => <MealItem>[],
    );
  }

  double? get currentMealProteinDegree {
    return mapOrNull(
      mealsInfo: (state) {
        final currentDate = state.currentDate;
        if (state.meals.isEmpty ||
            state.currentMealId == null ||
            currentDate == null) {
          return null;
        }
        final selectedDayMeals =
            state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

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
        if (state.meals.isEmpty ||
            state.currentMealId == null ||
            currentDate == null) {
          return null;
        }

        final selectedDayMeals =
            state.meals[currentDate.isoStringWithoutTime] ?? <MealsListItem>[];

        final MealsListItem? currentMeal = selectedDayMeals
            .firstWhereOrNull((item) => item.id == state.currentMealId);

        if (currentMeal == null) return null;

        return currentMeal.calorieDensity;
      },
    );
  }
}
