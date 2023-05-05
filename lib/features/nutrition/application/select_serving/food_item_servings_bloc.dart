import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/add_to_favorites_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/update_favorite_body.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';

part 'food_item_servings_event.dart';

part 'food_item_servings_state.dart';

part 'food_item_servings_bloc.freezed.dart';

@singleton
class FoodItemServingsBloc
    extends Bloc<FoodItemServingsEvent, FoodItemServingsState> {
  final NutritionService nutritionService;

  FoodItemServingsBloc(this.nutritionService)
      : super(const FoodItemServingsState.initial()) {
    on<FetchFoodItemServings>(_onFetchFoodItemServings);
    on<SetSelectedFoodItemServing>(_onSetSelectedFoodItemServing);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<UpdateFavorite>(_onUpdateFavorite);
    on<SetSelectedServingAmount>(_onSetSelectedServingAmount);
    on<SetMealCategoryFilters>(_onSetMealCategoryFilters);
    on<UpdateMealCategoryFilter>(_onUpdateMealCategoryFilter);
  }

  List<MealCategoryFilter> _initializeMealCategoryFilters() {
    return MealCategory.values.map((v) {
      return MealCategoryFilter(name: v.name, selected: false);
    }).toList();
  }

  IList<FoodItemServing> _getUpdatedServingsList(FoodItemServing serving) {
    return state.maybeMap(
      foodItemServings: (state) {
        return state.servings
            .toList()
            .map((e) => e.servingId == serving.servingId ? serving : e)
            .toIList();
      },
      orElse: () => <FoodItemServing>[].toIList(),
    );
  }

  List<MealCategoryFilter> _getUpdatedMealCategoryFilters(
    UpdateMealCategoryFilter filter,
  ) {
    return state.maybeMap(
      foodItemServings: (state) {
        return state.mealCategoryFilters.map((f) {
          return f.name == filter.name
              ? MealCategoryFilter(name: f.name, selected: filter.value)
              : f;
        }).toList();
      },
      orElse: () => <MealCategoryFilter>[],
    );
  }

  FutureOr<void> _onFetchFoodItemServings(
    FetchFoodItemServings event,
    Emitter<FoodItemServingsState> emit,
  ) async {
    emit(const FoodItemServingsState.loading());

    final response =
        await nutritionService.getFoodItemServings(event.foodItemId);

    response.fold(
      (l) => null,
      (r) {
        final servingList = r.data
            .map((e) => e.servingId == event.selectedItemId
                ? e.copyWith(numberOfUnits: event.initialServingAmount)
                : e)
            .toList();

        final selectedServing =
            servingList.firstWhere((e) => e.servingId == event.selectedItemId);

        emit(
          FoodItemServingsState.foodItemServings(
            servings: servingList.toIList(),
            mealCategoryFilters: _initializeMealCategoryFilters(),
            selectedServingAmount: selectedServing.numberOfUnits.toString(),
            selectedServing: selectedServing,
          ),
        );
      },
    );
  }

  FutureOr<void> _onSetSelectedFoodItemServing(
    SetSelectedFoodItemServing event,
    Emitter<FoodItemServingsState> emit,
  ) async {
    state.mapOrNull(foodItemServings: (state) {
      emit(
        state.copyWith(
          selectedServing: event.item,
          selectedServingAmount: event.item.numberOfUnits.toString(),
        ),
      );
    });
  }

  FutureOr<void> _onAddToFavorites(
    AddToFavorites event,
    Emitter<FoodItemServingsState> emit,
  ) async {
    await state.mapOrNull(foodItemServings: (state) async {
      final id = state.selectedServing?.servingId;
      final numberOfUnits = state.selectedServing?.numberOfUnits;

      if (id == null) return;

      final data = AddToFavoritesBody(
        numberOfUnits: numberOfUnits,
        mealCategories: state.selectedMealCategoriesNames,
      );

      final response =
          await nutritionService.addToFavorites(event.foodItemId, id, data);

      response.fold((l) => null, (r) {
        final updatedList = _getUpdatedServingsList(r.serving);

        emit(
          state.copyWith(
            servings: updatedList.toIList(),
            selectedServing: updatedList
                .firstWhere((e) => e.servingId == r.serving.servingId),
          ),
        );
      });
    });
  }

  FutureOr<void> _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<FoodItemServingsState> emit,
  ) async {
    await state.mapOrNull(foodItemServings: (state) async {
      final response = await nutritionService.removeFromFavorites(
        event.foodItemId,
        event.servingId,
      );

      response.fold((l) => null, (r) {
        final updatedList = _getUpdatedServingsList(r.serving);
        emit(
          state.copyWith(
            servings: updatedList,
            selectedServing: updatedList
                .firstWhere((e) => e.servingId == r.serving.servingId),
          ),
        );
      });
    });
  }

  FutureOr<void> _onUpdateFavorite(
    UpdateFavorite event,
    Emitter<FoodItemServingsState> emit,
  ) async {
    await state.mapOrNull(foodItemServings: (state) async {
      final id = state.selectedServing?.servingId;
      final numberOfUnits = state.selectedServing?.numberOfUnits;

      if (id == null) return;

      final data = UpdateFavoriteBody(
        mealCategories: state.selectedMealCategoriesNames,
        numberOfUnits: numberOfUnits,
      );

      final response = await nutritionService.updateFavorites(
        event.foodItemId,
        id,
        data,
      );

      response.fold((l) => null, (r) {
        final updatedList = _getUpdatedServingsList(r.serving);

        emit(
          state.copyWith(
            servings: updatedList,
            selectedServing: updatedList
                .firstWhere((e) => e.servingId == r.serving.servingId),
          ),
        );
      });
    });
  }

  void _onSetSelectedServingAmount(
    SetSelectedServingAmount event,
    Emitter<FoodItemServingsState> emit,
  ) {
    state.mapOrNull(foodItemServings: (state) {
      emit(
        state.copyWith(
          selectedServingAmount: event.amount,
        ),
      );
    });
  }

  void _onSetMealCategoryFilters(
    SetMealCategoryFilters event,
    Emitter<FoodItemServingsState> emit,
  ) {
    state.mapOrNull(foodItemServings: (state) {
      emit(
        state.copyWith(
          mealCategoryFilters: event.filters,
        ),
      );
    });
  }

  void _onUpdateMealCategoryFilter(
    UpdateMealCategoryFilter event,
    Emitter<FoodItemServingsState> emit,
  ) {
    state.mapOrNull(foodItemServings: (state) {
      emit(
        state.copyWith(
          mealCategoryFilters: _getUpdatedMealCategoryFilters(event),
        ),
      );
    });
  }
}
