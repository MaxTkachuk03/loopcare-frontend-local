import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_dish_food_item_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_food_item_in_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish/dish.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';

import 'dto/add_dish_to_meal_body.dart';

part 'dish_event.dart';
part 'dish_state.dart';
part 'dish_bloc.freezed.dart';

@singleton
class DishBloc extends Bloc<DishEvent, DishState> {
  final NutritionService nutritionService;
  final MealsBloc mealsBloc;

  DishBloc(
    this.nutritionService,
    this.mealsBloc,
  ) : super(const DishState.initial()) {
    on<SetCurrentDish>(_onSetCurrentDish);
    on<NutritionItemChanged>(_onNutritionItemChanged);
    on<UpdateFoodItemInDish>(_onUpdateFoodItemInDish);
    on<DeleteFoodItemFromDish>(_onDeleteFoodItemFromDish);
    on<DeleteFoodItemFromDishLocally>(_onDeleteFoodItemFromDishLocally);
    on<AddToMeal>(_onAddToMeal);
  }

  Dish _createDish(UpdateDishFoodItemResponse data) {
    return Dish(
      id: data.id,
      calorieDensity: data.calorieDensity,
      proteinDegree: data.proteinDegree,
      numberOfServings: data.numberOfServings,
      name: data.name,
      foodItems: data.foodItems,
      mealCategories: data.mealCategories,
      recipeId: data.recipeId,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      serving: data.serving,
    );
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
          final Dish selectedDish = _createDish(r);

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

  FutureOr<void> _onDeleteFoodItemFromDish(
    DeleteFoodItemFromDish event,
    Emitter<DishState> emit,
  ) async {
    await state.mapOrNull(dish: (state) async {
      final response = await nutritionService.deleteFoodItemFromDish(
        event.dishId,
        event.internalFoodItemId,
      );

      response.fold(
        (l) => null,
        (r) {
          final Dish selectedDish = _createDish(r);

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

  FutureOr<void> _onDeleteFoodItemFromDishLocally(
    DeleteFoodItemFromDishLocally event,
    Emitter<DishState> emit,
  ) async {
    await state.mapOrNull(dish: (state) async {
      final List<DishFoodItem> dishFoodItems = state.selectedDish.foodItems
          .where((e) => e.id != event.foodItemId)
          .toList();

      final selectedDish = Dish(
        id: state.selectedDish.id,
        calorieDensity: state.selectedDish.calorieDensity,
        proteinDegree: state.selectedDish.proteinDegree,
        numberOfServings: state.selectedDish.numberOfServings,
        name: state.selectedDish.name,
        foodItems: dishFoodItems,
        mealCategories: state.selectedDish.mealCategories,
        recipeId: state.selectedDish.recipeId,
        createdAt: state.selectedDish.createdAt,
        updatedAt: state.selectedDish.updatedAt,
        serving: state.selectedDish.serving,
      );

      emit(
        state.copyWith(
          selectedDish: selectedDish,
        ),
      );
    });
  }

  FutureOr<void> _onAddToMeal(
    AddToMeal event,
    Emitter<DishState> emit,
  ) async {
    await state.mapOrNull(dish: (state) async {
      final data = AddDishToMealBody(
        dishId: state.selectedDish.id,
        numberOfUnits: double.parse(event.numberOfServings),
      );

      final response = await nutritionService.addDishToMeal(event.mealId, data);

      response.fold(
        (l) => null,
        (r) {
          mealsBloc.add(MealsEvent.addDishToMeal(r));
        },
      );
    });
  }
}
