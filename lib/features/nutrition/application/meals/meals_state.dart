part of 'meals_bloc.dart';

@freezed
class MealsState with _$MealsState {
  const MealsState._();

  const factory MealsState.initial() = _Initial;

  const factory MealsState.loading() = _Loading;

  const factory MealsState.error(RequestError fetchError) = _Error;

  const factory MealsState.mealsInfo({
    int? currentMealId,
    DateTime? currentDate,
    String? currentMealCategory,
    required IList<MealsListItem> meals,
    FoodItemServing? selectedServing,
  }) = _MealsInfo;

  DateTime get getCurrentDate {
    return maybeWhen(
      mealsInfo: (
        currentMealId,
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

  List<String> get filledCategories {
    return map(
      mealsInfo: (state) {
        if (state.meals.isEmpty || state.currentDate == null) {
          return <String>[];
        }
        // TODO store as a Map for optimization
        return state.meals
            .where((item) => item.loggingDate.isSameDate(state.currentDate!))
            .toList()
            .map((e) => e.mealCategory)
            .toList()
            .toSet()
            .toList();
      },
      error: (_Error value) {
        return <String>[];
      },
      initial: (_Initial value) {
        return <String>[];
      },
      loading: (_Loading value) {
        return <String>[];
      },
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

  FoodItemServing? get currentMealServing {
    return mapOrNull(
      mealsInfo: (state) {
        if (state.meals.isEmpty || state.currentMealCategory == null) {
          return null;
        }
        return state.meals
            .firstWhere(
                (item) => item.mealCategory == state.currentMealCategory)
            .serving;
      },
    );
  }

  List<MealItem> get currentFoodItems {
    return map(
      mealsInfo: (state) {
        if (state.meals.isEmpty || state.currentMealId == null) {
          return <MealItem>[];
        }

        return state.meals
            .firstWhere((item) => item.id == state.currentMealId)
            .mealItems
            .toList();
      },
      error: (_Error value) {
        return <MealItem>[];
      },
      initial: (_Initial value) {
        return <MealItem>[];
      },
      loading: (_Loading value) {
        return <MealItem>[];
      },
    );
  }
}
