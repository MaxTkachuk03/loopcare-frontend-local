import 'dart:async';
import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
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
    on<FilterFavorites>(_onFilterFavorites);
    on<ItemAdded>(_onItemAdded);
    on<ItemDeleted>(_onItemDeleted);
    on<ItemsDeselectAll>(_onItemsDeselectAll);
  }

  FutureOr<void> _onFetchFavorites(
    FetchFavorites event,
    Emitter<SelectFoodState> emit,
  ) async {
    emit(const SelectFoodState.loading());

    final response = await nutritionService.getFavorites();

    response.fold(
      (error) {
        emit(SelectFoodState.error(error));
      },
      (response) {
        emit(SelectFoodState.selectFood(
          favorites: response.data.toIList(),
          dishes: [].toIList(),
          mealFavoritesCategories: MealFavoritesCategory.values
              .map((e) => MealCategoryFilter(name: e.name, selected: false))
              .toIList(),
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
      final mealList =
          event.filtersList.where((e) => e.selected).map((element) {
        final label = MealFavoritesCategory.values
            .firstWhereOrNull((e) => e.name == element.name)
            ?.label;

        return label;
      });

      final isSelectedAll = mealList.contains(null);
      final filters = isSelectedAll
          ? <String>[].toList()
          : mealList.whereNotNull().toList();

      final response = await nutritionService.getFilteredFavorites(filters);

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

  FutureOr<void> _onItemAdded(
    ItemAdded event,
    Emitter<SelectFoodState> emit,
  ) async {
    state.mapOrNull(selectFood: (state) {
      emit(state.copyWith(
          selectedFavoritesItems: state.selectedFavoritesItems.add(event.foodItem)));
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
}
