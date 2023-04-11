part of 'meals_bloc.dart';

@freezed
class MealsState with _$MealsState {
  const MealsState._();

  const factory MealsState.initial() = _Initial;

  const factory MealsState.loading() = _Loading;

  const factory MealsState.error(RequestError fetchError) = _Error;

  const factory MealsState.meals({
    required String? currentMealId,
    required DateTime currentDate,
    required String currentMealCategory,
    required IList<MealsListItem> meals,
    required FoodItemServing? selectedServing,
  }) = _Meals;

  String? get getCurrentMealId {
    return mapOrNull(
      meals: (state) => state.meals
          .firstWhere((item) => item.mealCategory == state.currentMealCategory)
          .id
          .toString(),
    );
  }

  String? get currentMealCategory {
    return mapOrNull(
      meals: (state) => state.currentMealCategory.capitalizeOnlyFirstLetter(),
    );
  }

  FoodItemServing? get currentMealServing {
    return mapOrNull(
      meals: (state) => state.meals
          .firstWhere((item) => item.mealCategory == state.currentMealCategory)
          .serving,
    );
  }

  List<MealItem>? get currentFoodItems {
    return mapOrNull(meals: (state) {
      if (state.meals.isEmpty) {
        return null;
      }
      return state.meals
          .firstWhere((item) => item.mealCategory == state.currentMealCategory)
          .mealItems
          .toList();
    });
  }
}
