import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/add_food_item_to_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/clone_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_dish_food_item_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_dish_in_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_food_item_in_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish/dish.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:rxdart/rxdart.dart';

import 'dto/add_dish_to_meal_body.dart';

part 'dish_event.dart';

part 'dish_state.dart';

part 'dish_bloc.freezed.dart';

@singleton
class DishBloc extends Bloc<DishEvent, DishState> {
  final NutritionService nutritionService;
  final MealsBloc mealsBloc;
  final SelectFoodBloc selectFoodBloc;
  final NutritionInstructionsBloc nutritionInstructionsBloc;

  DishBloc(
    this.nutritionService,
    this.mealsBloc,
    this.selectFoodBloc,
    this.nutritionInstructionsBloc,
  ) : super(const DishState.initial()) {
    on<GetClonedDish>(_onGetClonedDish);
    on<GetDishById>(_onGetDishById);
    on<NutritionItemChanged>(_onNutritionItemChanged);
    on<ServingChanged>(
      _onServingChanged,
      transformer: (events, mapper) =>
          events.distinct().debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
    on<UpdateFoodItemInDish>(_onUpdateFoodItemInDish);
    on<DeleteFoodItemFromDish>(_onDeleteFoodItemFromDish);
    on<AddToMeal>(_onAddToMeal);
    on<AddFoodItemToDish>(_onAddFoodItemToDish);
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

  FutureOr<void> _onGetClonedDish(
    GetClonedDish event,
    Emitter<DishState> emit,
  ) async {
    emit(const DishState.loading());

    final response = await nutritionService.cloneDish(
      CloneDishBody(dishId: event.dishId),
    );

    response.fold(
      (l) => emit(DishState.error(l)),
      (r) {
        final Dish selectedDish = _createDish(r);

        emit(DishState.dish(
          originalDishId: event.dishId,
          selectedDish: selectedDish,
        ));
      },
    );
  }

  FutureOr<void> _onGetDishById(
    GetDishById event,
    Emitter<DishState> emit,
  ) async {
    emit(const DishState.loading());

    final response = await nutritionService.getDishById(event.dishId);

    response.fold(
      (l) => emit(DishState.error(l)),
      (r) {
        final Dish selectedDish = _createDish(r);

        emit(DishState.dish(
          originalDishId: event.dishId,
          selectedDish: selectedDish,
        ));
      },
    );
  }

  FutureOr<void> _onNutritionItemChanged(
    NutritionItemChanged event,
    Emitter<DishState> emit,
  ) async {
    state.mapOrNull(dish: (state) {
      emit(state.copyWith(currentNutritionType: event.item));
    });
  }

  FutureOr<void> _onUpdateFoodItemInDish(
    UpdateFoodItemInDish event,
    Emitter<DishState> emit,
  ) async {
    await state.mapOrNull(
      dish: (state) async {
        final response = await nutritionService.updateFoodItemInDish(
          event.dishId,
          event.internalFoodItemId,
          UpdateFoodItemInDishBody(
            numberOfUnits: event.numberOfUnits,
            servingId: event.servingId,
          ),
        );

        response.fold(
          (l) => emit(DishState.error(l)),
          (r) {
            final Dish selectedDish = _createDish(r);

            emit(
              state.copyWith(
                selectedDish: selectedDish,
              ),
            );
          },
        );
      },
    );
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
        (l) => emit(DishState.error(l)),
        (r) {
          final Dish selectedDish = _createDish(r);

          emit(
            state.copyWith(
              selectedDish: selectedDish,
            ),
          );
        },
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
        (l) => emit(DishState.error(l)),
        (r) {
          mealsBloc.add(MealsEvent.addDishToMeal(r));
        },
      );
    });
  }

  FutureOr<void> _onAddFoodItemToDish(
    AddFoodItemToDish event,
    Emitter<DishState> emit,
  ) async {
    await state.mapOrNull(dish: (state) async {
      final dishId = state.selectedDish.id;

      final data = AddFoodItemToDishBody(
        numberOfUnits: event.numberOfUnits,
        servingId: event.servingId,
        externalFoodItemId: event.externalFoodItemId,
      );

      final response = await nutritionService.addFoodItemToDish(dishId, data);

      response.fold(
        (l) => emit(DishState.error(l)),
        (r) {
          final Dish selectedDish = _createDish(r);

          emit(
            state.copyWith(
              selectedDish: selectedDish,
            ),
          );
        },
      );
    });
  }

  FutureOr<void> _onServingChanged(ServingChanged event, Emitter<DishState> emit) async {
    await state.mapOrNull(
      dish: (state) async {
        final response = await nutritionService.updateDishInMeal(
          mealId: event.mealId,
          dishId: state.selectedDish.id,
          data: UpdateDishInMealBody(numberOfUnits: event.servingAmount),
        );

        response.fold(
          (l) => emit(DishState.error(l)),
          (r) {
            final Dish selectedDish = _createDish(r);

            emit(
              state.copyWith(
                selectedDish: selectedDish,
              ),
            );
          },
        );
      },
    );
  }
}
