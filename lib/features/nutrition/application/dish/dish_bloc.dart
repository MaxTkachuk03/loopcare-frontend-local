import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_food_item_in_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish/dish.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';

part 'dish_event.dart';
part 'dish_state.dart';
part 'dish_bloc.freezed.dart';

@singleton
class DishBloc extends Bloc<DishEvent, DishState> {
  final NutritionService nutritionService;

  DishBloc(this.nutritionService) : super(const DishState.initial()) {
    on<SetCurrentDish>(_onSetCurrentDish);
    on<NutritionItemChanged>(_onNutritionItemChanged);
    on<UpdateFoodItemInDish>(_onUpdateFoodItemInDish);
  }

  FutureOr<void> _onSetCurrentDish(
    SetCurrentDish event,
    Emitter<DishState> emit,
  ) async {
    emit(const DishState.loading());

    emit(
      DishState.dish(
        selectedDish: event.dish,
        currentNutritionItem: event.dish.serving.list
            .firstWhere((e) => e.key == NutritionValuesTypes.calories.name),
      ),
    );
  }

  FutureOr<void> _onNutritionItemChanged(
    NutritionItemChanged event,
    Emitter<DishState> emit,
  ) async {
    state.mapOrNull(dish: (state) {
      emit(state.copyWith(currentNutritionItem: event.item));
    });
  }

  FutureOr<void> _onUpdateFoodItemInDish(
    UpdateFoodItemInDish event,
    Emitter<DishState> emit,
  ) async {
    await state.mapOrNull(dish: (state) async {
      final response = await nutritionService.updateFoodItemInDish(
        event.dishId,
        event.internalFoodItemId,
        UpdateFoodItemInDishBody(
          numberOfUnits: event.numberOfUnits,
          servingId: event.servingId,
        ),
      );

      response.fold(
        (l) => null,
        (r) {
          final selectedDish = Dish(
            id: r.id,
            calorieDensity: r.calorieDensity,
            proteinDegree: r.proteinDegree,
            numberOfServings: r.numberOfServings,
            name: r.name,
            foodItems: r.foodItems,
            mealCategory: r.mealCategory,
            recipeId: r.recipeId,
            createdAt: r.createdAt,
            updatedAt: r.updatedAt,
            serving: r.serving,
          );

          final updatedNutritionItem = selectedDish.serving.list
              .firstWhere((e) => e.key == state.currentNutritionItem.key);

          emit(
            state.copyWith(
              selectedDish: selectedDish,
              currentNutritionItem: updatedNutritionItem,
            ),
          );
        },
      );
    });
  }
}
