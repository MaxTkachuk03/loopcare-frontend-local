import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/add_food_item_to_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_dish_food_item_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_food_item_in_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/create_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/create_dish_from_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/create_dish_from_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/update_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish/dish.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_favorites_category/dish_favorites_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

part 'edit_dish_event.dart';
part 'edit_dish_state.dart';
part 'edit_dish_bloc.freezed.dart';

@singleton
class EditDishBloc extends Bloc<EditDishEvent, EditDishState> {
  final NutritionService nutritionService;

  EditDishBloc(this.nutritionService) : super(const EditDishState.initial()) {
    on<GetDish>(_onGetDish);
    on<CreateDishFromRecipe>(_onCreateDishFromRecipe);
    on<CreateDishFromMeal>(_onCreateDishFromMeal);
    on<CreateDish>(_onCreateDish);
    on<NutritionItemChanged>(_onNutritionItemChanged);
    on<AddFoodItemToDish>(_onAddFoodItemToDish);
    on<DeleteFoodItemFromDish>(_onDeleteFoodItemFromDish);
    on<UpdateFoodItemInDish>(_onUpdateFoodItemInDish);
    on<DeleteDish>(_onDeleteDish);
    on<UpdateDish>(_onUpdateDish);
  }
  // TODO ask backend to wrap server response into data object so we can use Dish model as a response type
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

  FutureOr<void> _onGetDish(
    GetDish event,
    Emitter<EditDishState> emit,
  ) async {
    emit(const EditDishState.loading());

    final response = await nutritionService.getDishById(event.id);

    response.fold(
      (e) {
        emit(EditDishState.error(e));
      },
      (r) {
        final Dish dish = _createDish(r);

        emit(EditDishState.dishInfo(
          currentDish: dish,
        ));
      },
    );
  }

  FutureOr<void> _onCreateDishFromRecipe(
    CreateDishFromRecipe event,
    Emitter<EditDishState> emit,
  ) async {
    emit(const EditDishState.loading());

    final data = CreateDishFromRecipeBody(
      mealRecipeId: event.mealRecipeId,
      numberOfUnits: event.numberOfUnits,
      mealCategories: event.mealCategories,
    );

    final response = await nutritionService.createDishFromRecipe(data);

    response.fold(
      (e) {
        emit(EditDishState.error(e));
      },
      (r) {
        final Dish dish = _createDish(r);

        emit(EditDishState.dishInfo(
          currentDish: dish,
        ));
      },
    );
  }

  FutureOr<void> _onCreateDishFromMeal(
    CreateDishFromMeal event,
    Emitter<EditDishState> emit,
  ) async {
    emit(const EditDishState.loading());

    final data = CreateDishFromMealBody(
      mealId: event.mealId,
      numberOfUnits: event.numberOfUnits,
      mealCategory: event.mealCategory,
      name: event.name,
    );

    final response = await nutritionService.createDishFromMeal(data);

    response.fold(
      (e) {
        emit(EditDishState.error(e));
      },
      (r) {
        final Dish dish = _createDish(r);

        emit(EditDishState.dishInfo(
          currentDish: dish,
        ));
      },
    );
  }

  FutureOr<void> _onCreateDish(
    CreateDish event,
    Emitter<EditDishState> emit,
  ) async {
    emit(const EditDishState.loading());

    final data = CreateDishBody(
      numberOfUnits: event.numberOfUnits,
      mealCategories: event.mealCategories,
      name: event.name,
    );

    final response = await nutritionService.createDish(data);

    response.fold(
      (e) {
        emit(EditDishState.error(e));
      },
      (r) {
        final Dish dish = _createDish(r);

        emit(EditDishState.dishInfo(
          currentDish: dish,
        ));
      },
    );
  }

  FutureOr<void> _onNutritionItemChanged(
    NutritionItemChanged event,
    Emitter<EditDishState> emit,
  ) async {
    state.mapOrNull(dishInfo: (state) {
      emit(state.copyWith(currentNutritionType: event.item));
    });
  }

  FutureOr<void> _onAddFoodItemToDish(
    AddFoodItemToDish event,
    Emitter<EditDishState> emit,
  ) async {
    await state.mapOrNull(dishInfo: (state) async {
      final dishId = state.currentDish.id;

      final data = AddFoodItemToDishBody(
        numberOfUnits: event.numberOfUnits,
        servingId: event.servingId,
        externalFoodItemId: event.externalFoodItemId,
      );

      final response = await nutritionService.addFoodItemToDish(dishId, data);

      response.fold(
        (l) => null,
        (r) {
          final Dish selectedDish = _createDish(r);

          emit(
            state.copyWith(
              currentDish: selectedDish,
            ),
          );
        },
      );
    });
  }

  FutureOr<void> _onDeleteFoodItemFromDish(
    DeleteFoodItemFromDish event,
    Emitter<EditDishState> emit,
  ) async {
    await state.mapOrNull(dishInfo: (state) async {
      final response = await nutritionService.deleteFoodItemFromDish(
        event.dishId,
        event.internalFoodItemId,
      );

      response.fold(
        (l) => null,
        (r) {
          final Dish selectedDish = _createDish(r);

          emit(
            state.copyWith(
              currentDish: selectedDish,
            ),
          );
        },
      );
    });
  }

  FutureOr<void> _onUpdateFoodItemInDish(
    UpdateFoodItemInDish event,
    Emitter<EditDishState> emit,
  ) async {
    await state.mapOrNull(dishInfo: (state) async {
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

          emit(
            state.copyWith(
              currentDish: selectedDish,
            ),
          );
        },
      );
    });
  }

  FutureOr<void> _onDeleteDish(
    DeleteDish event,
    Emitter<EditDishState> emit,
  ) async {
    await state.mapOrNull(dishInfo: (state) async {
      final dishId = state.currentDish.id;

      final response = await nutritionService.deleteDish(dishId);

      response.fold(
        (l) => null,
        (r) {
          emit(const EditDishState.deleted());
        },
      );
    });
  }

  FutureOr<void> _onUpdateDish(
    UpdateDish event,
    Emitter<EditDishState> emit,
  ) async {
    await state.mapOrNull(dishInfo: (state) async {
      final dishId = state.currentDish.id;

      final data = UpdateDishBody(
        numberOfUnits: event.numberOfUnits,
        numberOfServings: event.numberOfServings,
        mealCategories: event.mealCategories,
        name: event.name,
      );

      final response = await nutritionService.updateDishById(dishId, data);

      response.fold(
        (l) => null,
        (r) {
          emit(const EditDishState.saved());
        },
      );
    });
  }
}
