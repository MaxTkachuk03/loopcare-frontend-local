part of 'food_item_servings_bloc.dart';

@freezed
class FoodItemServingsState with _$FoodItemServingsState {
  factory FoodItemServingsState.initial() => FoodItemServingsState(
        servings: <FoodItemServing>[].toIList(),
        selectedServing: null,
        selectedServingAmount: '1',
        mealCategoryFilters: <MealCategoryFilter>[].toList(),
      );

  const factory FoodItemServingsState({
    required IList<FoodItemServing> servings,
    required FoodItemServing? selectedServing,
    required String selectedServingAmount,
    required List<MealCategoryFilter> mealCategoryFilters,
  }) = _FoodItemServingsState;

  num get selectedServingCalories {
    if (selectedServing == null) return 0;
    final calories = selectedServing?.calories ?? 0;
    final units = selectedServing?.numberOfUnits ?? 1;

    return (calories * double.parse(selectedServingAmount) / units);
  }

  bool get hasSelectedMealCategoryFilters {
    return mealCategoryFilters.any((e) => e.selected);
  }

  List<String> get selectedMealCategoriesNames {
    return mealCategoryFilters
        .where((e) => e.selected)
        .map((e) => e.name)
        .toList();
  }

  List<MealCategoryFilter> get filtersForSelectedServing {
    return mealCategoryFilters.map((f) {
      final selectedFiltersValues = selectedServing?.favoriteMealCategories;

      return MealCategoryFilter(
        name: f.name.toLowerCase(),
        selected: selectedFiltersValues == null
            ? false
            : selectedFiltersValues.contains(f.name.toLowerCase()),
      );
    }).toList();
  }

  const FoodItemServingsState._();
}
