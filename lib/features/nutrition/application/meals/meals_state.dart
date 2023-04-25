part of 'meals_bloc.dart';

@freezed
class MealsState with _$MealsState {
  const MealsState._();

  const factory MealsState.initial() = _Initial;

  const factory MealsState.loading() = _Loading;

  const factory MealsState.updating() = _Updating;

  const factory MealsState.error(RequestError fetchError) = _Error;

  const factory MealsState.meals({
    int? currentMealId,
    DateTime? currentDate,
    String? currentMealCategory,
    required IList<MealsListItem> meals,
    FoodItemServing? selectedServing,
  }) = Meals;

  bool get isNeedToHideOnDashboard {
    return maybeWhen(
      meals: (
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
      meals: (
        currentMealId,
        currentDate,
        currentMealCategory,
        meals,
        selectedServing,
      ) =>
          currentDate
              ?.isAfter(DateTime.now().subtract(const Duration(days: 7))) ??
          false,
      orElse: () => false,
    );
  }

  List<String> get filledCategories {
    return map(
      meals: (state) {
        if (state.meals.isEmpty || state.currentDate == null) {
          return <String>[];
        }
        var filledCategory = state.meals
            .where((item) => item.loggingDate.isSameDate(state.currentDate!))
            .toList()
            .map((e) => e.mealCategory)
            .toList()
            .toSet()
            .toList();

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
      updating: (_Updating value) {
        return <String>[];
      },
    );
  }

  int? get getCurrentMealId {
    return mapOrNull(
      meals: (state) => state.meals
          .firstWhere((item) => item.mealCategory == state.currentMealCategory)
          .id,
    );
  }

  String? get mealListLength {
    return mapOrNull(
      meals: (state) => state.meals.length.toString(),
    );
  }

  String? get currentMealCategory {
    return mapOrNull(
      meals: (state) => state.currentMealCategory?.capitalizeOnlyFirstLetter(),
    );
  }

  FoodItemServing? get currentMealServing {
    return mapOrNull(meals: (state) {
      if (state.meals.isEmpty || state.currentMealCategory == null) return null;
      return state.meals
          .firstWhere((item) => item.mealCategory == state.currentMealCategory)
          .serving;
    });
  }

  List<MealItem> get currentFoodItems {
    return map(
      meals: (state) {
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
      updating: (_Updating value) {
        return <MealItem>[];
      },
    );
  }
}
