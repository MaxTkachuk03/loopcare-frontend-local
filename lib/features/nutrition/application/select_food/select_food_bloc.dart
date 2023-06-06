import 'dart:async';
import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_dish_food_item_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish/dish.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_favorites_category/dish_favorites_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_favorites_category/meal_favorites_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';

part 'select_food_event.dart';

part 'select_food_state.dart';

part 'select_food_bloc.freezed.dart';

@singleton
class SelectFoodBloc extends Bloc<SelectFoodEvent, SelectFoodState> {
  final NutritionService nutritionService;

  SelectFoodBloc(this.nutritionService)
      : super(const SelectFoodState.initial()) {
    on<FetchFavorites>(_onFetchFavorites);
    on<FetchDishes>(_onFetchDishes);
    on<FilterFavorites>(_onFilterFavorites);
    on<FilterDishes>(_onFilterDishes);
    on<ItemAdded>(_onItemAdded);
    on<ItemDeleted>(_onItemDeleted);
    on<ItemsDeselectAll>(_onItemsDeselectAll);
    on<RemoveDish>(_onRemoveDish);
  }

  IList<MealCategoryFilter> _getMealFavoriteCategories(String defaultSelected) {
    return MealFavoritesCategory.values
        .map((e) => MealCategoryFilter(
            name: e.name, selected: e.value == defaultSelected))
        .toIList();
  }

  IList<MealCategoryFilter> _getDishFavoriteCategories(String defaultSelected) {
    return DishFavoritesCategory.values
        .map((e) => MealCategoryFilter(
            name: e.name, selected: e.value == defaultSelected))
        .toIList();
  }

  FutureOr<void> _onFetchFavorites(
    FetchFavorites event,
    Emitter<SelectFoodState> emit,
  ) async {
    final dishes = state.mapOrNull(selectFood: (s) => s.dishes);
    final dishesFilters =
        state.mapOrNull(selectFood: (s) => s.dishFavoritesCategories);

    emit(const SelectFoodState.loading());

    final response = await nutritionService.getFavorites([event.mealCategory]);

    response.fold(
      (error) {
        emit(SelectFoodState.error(error));
      },
      (response) {
        emit(SelectFoodState.selectFood(
          favorites: response.data.toIList(),
          dishes: dishes ?? <Dish>[].toIList(),
          mealFavoritesCategories:
              _getMealFavoriteCategories(event.mealCategory),
          dishFavoritesCategories:
              dishesFilters ?? <MealCategoryFilter>[].toIList(),
          selectedFavoritesItems: <FoodItem>[].toIList(),
        ));
      },
    );
  }

  FutureOr<void> _onFetchDishes(
    FetchDishes event,
    Emitter<SelectFoodState> emit,
  ) async {
    final favorites = state.mapOrNull(selectFood: (s) => s.favorites);
    final favoritesFiltes =
        state.mapOrNull(selectFood: (s) => s.mealFavoritesCategories);

    final response = await nutritionService.getDishes([event.mealCategory]);

    response.fold(
      (error) {
        emit(SelectFoodState.error(error));
      },
      (response) {
        emit(SelectFoodState.selectFood(
          favorites: favorites ?? <FoodItem>[].toIList(),
          dishes: response.data.toIList(),
          mealFavoritesCategories:
              favoritesFiltes ?? <MealCategoryFilter>[].toIList(),
          dishFavoritesCategories:
              _getDishFavoriteCategories(event.mealCategory),
          selectedFavoritesItems: <FoodItem>[].toIList(),
        ));
      },
    );
  }

  FutureOr<void> _onFilterFavorites(
    FilterFavorites event,
    Emitter<SelectFoodState> emit,
  ) async {
    await state.mapOrNull(selectFood: (state) async {
      // TODO refactor logic to get filter values fron the popup
      final selectedFiltersValues =
          event.filtersList.where((e) => e.selected).map((element) {
        final label = MealFavoritesCategory.values
            .firstWhereOrNull((e) => e.name == element.name)
            ?.value;

        return label;
      });

      final isSelectedAll = selectedFiltersValues.contains(null);

      final filters = isSelectedAll
          ? <String>[].toList()
          : selectedFiltersValues.whereNotNull().toList();

      final response = await nutritionService.getFavorites(filters);

      response.fold(
        (l) => null,
        (r) => emit(
          state.copyWith(
            mealFavoritesCategories: event.filtersList,
            favorites: r.data.toIList(),
          ),
        ),
      );
    });
  }

  FutureOr<void> _onFilterDishes(
    FilterDishes event,
    Emitter<SelectFoodState> emit,
  ) async {
    await state.mapOrNull(selectFood: (state) async {
      final selectedFiltersValues =
          event.filtersList.where((e) => e.selected).map((element) {
        final label = DishFavoritesCategory.values
            .firstWhereOrNull((e) => e.name == element.name)
            ?.value;

        return label;
      });

      final isSelectedAll = selectedFiltersValues.contains(null);

      final filters = isSelectedAll
          ? <String>[].toList()
          : selectedFiltersValues.whereNotNull().toList();

      final response = await nutritionService.getDishes(filters);

      response.fold(
        (l) => null,
        (r) => emit(
          state.copyWith(
            dishFavoritesCategories: event.filtersList,
            dishes: r.data.toIList(),
          ),
        ),
      );
    });
  }

  FutureOr<void> _onItemAdded(
    ItemAdded event,
    Emitter<SelectFoodState> emit,
  ) async {
    state.mapOrNull(selectFood: (state) {
      emit(state.copyWith(
          selectedFavoritesItems:
              state.selectedFavoritesItems.add(event.foodItem)));
    });
  }

  FutureOr<void> _onItemDeleted(
    ItemDeleted event,
    Emitter<SelectFoodState> emit,
  ) {
    state.mapOrNull(selectFood: (state) {
      emit(state.copyWith(
          selectedFavoritesItems:
              state.selectedFavoritesItems.remove(event.foodItem)));
    });
  }

  FutureOr<void> _onItemsDeselectAll(
    ItemsDeselectAll event,
    Emitter<SelectFoodState> emit,
  ) {
    state.mapOrNull(selectFood: (state) {
      emit(state.copyWith(selectedFavoritesItems: <FoodItem>[].toIList()));
    });
  }

  FutureOr<void> _onRemoveDish(
    RemoveDish event,
    Emitter<SelectFoodState> emit,
  ) {
    state.mapOrNull(selectFood: (state) {
      final dishes = state.dishes.where((e) => e.id != event.dish.id).toIList();

      emit(state.copyWith(dishes: dishes));
    });
  }
}
