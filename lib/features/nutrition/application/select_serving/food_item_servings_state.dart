part of 'food_item_servings_bloc.dart';

@freezed
class FoodItemServingsState with _$FoodItemServingsState {
  const FoodItemServingsState._();

  const factory FoodItemServingsState.initial() = Initial;

  const factory FoodItemServingsState.loading() = Loading;

  const factory FoodItemServingsState.foodItemServings({
    required List<ServingSize> servings,
    required ServingSize? selectedServing,
    required String selectedServingAmount,
    required List<MealCategoryFilter> mealCategoryFilters,
  }) = FoodItemServings;

//TODO: old state style
  const factory FoodItemServingsState.error(RequestError fetchError) = Error;

  ServingSize? get selectedServingItem {
    return mapOrNull(foodItemServings: (state) => state.selectedServing);
  }

  String? get selectedServingAmount {
    return mapOrNull(foodItemServings: (state) => state.selectedServingAmount);
  }

  List<ServingSize> get servingsList {
    return maybeMap(
      foodItemServings: (state) => state.servings,
      orElse: () => <ServingSize>[].toList(),
    );
  }

  String get selectedServingCalories {
    return maybeMap(
      foodItemServings: (state) {
        if (state.selectedServing == null) return '0';
        final calories = state.selectedServing?.calories ?? 0;
        final units = state.selectedServing?.numberOfUnits ?? 1;

        return (calories * double.parse(state.selectedServingAmount) / units).round().toString();
      },
      orElse: () => '0',
    );
  }

  bool get hasSelectedMealCategoryFilters {
    return maybeMap(
      foodItemServings: (state) {
        return state.mealCategoryFilters.any((e) => e.selected);
      },
      orElse: () => false,
    );
  }

  List<String> get selectedMealCategoriesNames {
    return maybeMap(
      foodItemServings: (state) {
        return state.mealCategoryFilters.where((e) => e.selected).map((e) => e.name).toList();
      },
      orElse: () => <String>[],
    );
  }

  List<MealCategoryFilter> get filtersForSelectedServing {
    return maybeMap(
      foodItemServings: (state) {
        return state.mealCategoryFilters.map((f) {
          final selectedFiltersValues = state.selectedServing?.favoriteMealCategories;

          return MealCategoryFilter(
            name: f.name.toLowerCase(),
            title: f.title,
            selected: selectedFiltersValues == null
                ? false
                : selectedFiltersValues.contains(f.name.toLowerCase()),
          );
        }).toList();
      },
      orElse: () => <MealCategoryFilter>[],
    );
  }
}
