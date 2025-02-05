import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
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

  EditDishBloc(this.nutritionService) : super(const EditDishState.initial(EditDishData())) {
    on<GetDish>(_onGetDish);
    on<CreateDishFromRecipe>(_onCreateDishFromRecipe);
    on<CreateDishFromExternalRecipe>(_onCreateDishFromExternalRecipe);
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
    emit(EditDishState.loading(state.data.copyWith(isLoading: true)));

    final response = await nutritionService.getDishById(event.id);

    response.fold(
      (l) => emit(EditDishState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        EditDishState.dishInfo(
          state.data.copyWith(
            currentDish: _createDish(r),
            isLoading: true,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onCreateDishFromExternalRecipe(
    CreateDishFromExternalRecipe event,
    Emitter<EditDishState> emit,
  ) async {
    emit(EditDishState.loading(state.data.copyWith(isLoading: true)));

    final data = CreateDishFromRecipeBody(
      recipeId: event.mealRecipeId,
      numberOfUnits: event.numberOfUnits,
      mealCategories: event.mealCategories,
    );

    final response = await nutritionService.createDishFromRecipe(data);

    response.fold(
      (l) => emit(EditDishState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        EditDishState.dishInfo(
          state.data.copyWith(
            currentDish: _createDish(r),
            isLoading: true,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onCreateDishFromRecipe(
    CreateDishFromRecipe event,
    Emitter<EditDishState> emit,
  ) async {
    emit(EditDishState.loading(state.data.copyWith(isLoading: true)));

    final data = CreateDishFromRecipeBody(
      mealRecipeId: event.mealRecipeId,
      numberOfUnits: event.numberOfUnits,
      mealCategories: event.mealCategories,
    );

    final response = await nutritionService.createDishFromRecipe(data);

    response.fold(
      (l) => emit(EditDishState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        EditDishState.dishInfo(
          state.data.copyWith(
            currentDish: _createDish(r),
            isLoading: true,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onCreateDishFromMeal(
    CreateDishFromMeal event,
    Emitter<EditDishState> emit,
  ) async {
    emit(EditDishState.loading(state.data.copyWith(isLoading: true)));

    final data = CreateDishFromMealBody(
      mealId: event.mealId,
      numberOfUnits: event.numberOfUnits,
      mealCategory: event.mealCategory,
      name: event.name,
    );

    final response = await nutritionService.createDishFromMeal(data);

    response.fold(
      (l) => emit(EditDishState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        EditDishState.dishInfo(
          state.data.copyWith(
            currentDish: _createDish(r),
            isLoading: true,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onCreateDish(
    CreateDish event,
    Emitter<EditDishState> emit,
  ) async {
    emit(EditDishState.loading(state.data.copyWith(isLoading: true)));

    final data = CreateDishBody(
      numberOfUnits: event.numberOfUnits,
      mealCategories: event.mealCategories,
      name: event.name,
    );

    final response = await nutritionService.createDish(data);

    response.fold(
      (l) => emit(EditDishState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        EditDishState.dishInfo(
          state.data.copyWith(
            currentDish: _createDish(r),
            isLoading: true,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onNutritionItemChanged(
    NutritionItemChanged event,
    Emitter<EditDishState> emit,
  ) async {
    emit(
      EditDishState.dishInfo(
        state.data.copyWith(
          currentNutritionType: event.item,
        ),
      ),
    );
  }

  FutureOr<void> _onAddFoodItemToDish(
    AddFoodItemToDish event,
    Emitter<EditDishState> emit,
  ) async {
    final dishId = state.data.currentDish?.id ?? -1;

    final data = AddFoodItemToDishBody(
      numberOfUnits: event.numberOfUnits,
      servingId: event.servingId,
      externalFoodItemId: event.externalFoodItemId,
    );

    final response = await nutritionService.addFoodItemToDish(dishId, data);

    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.foodLogged,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
        AnalyticsParameters.mealId: event.externalFoodItemId,
        AnalyticsParameters.foodItem: event.externalFoodItemId,
        AnalyticsParameters.servingId: event.servingId,
        AnalyticsParameters.numberOfUnits: event.numberOfUnits.toString(),
        AnalyticsParameters.isDishes: 'true',
      },
    );

    response.fold(
      (l) => emit(EditDishState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        EditDishState.dishInfo(
          state.data.copyWith(
            currentDish: _createDish(r),
            isLoading: true,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onDeleteFoodItemFromDish(
    DeleteFoodItemFromDish event,
    Emitter<EditDishState> emit,
  ) async {
    final response = await nutritionService.deleteFoodItemFromDish(
      event.dishId,
      event.internalFoodItemId,
    );

    response.fold(
      (l) => emit(EditDishState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        EditDishState.dishInfo(
          state.data.copyWith(
            currentDish: _createDish(r),
            isLoading: true,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onUpdateFoodItemInDish(
    UpdateFoodItemInDish event,
    Emitter<EditDishState> emit,
  ) async {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.foodLogged,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
        AnalyticsParameters.mealId: event.internalFoodItemId,
        AnalyticsParameters.servingId: event.servingId,
        AnalyticsParameters.numberOfUnits: event.numberOfUnits.toString(),
        AnalyticsParameters.isDishes: 'true',
      },
    );

    final response = await nutritionService.updateFoodItemInDish(
      event.dishId,
      event.internalFoodItemId,
      UpdateFoodItemInDishBody(
        numberOfUnits: event.numberOfUnits,
        servingId: event.servingId,
      ),
    );

    response.fold(
      (l) => emit(EditDishState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        EditDishState.dishInfo(
          state.data.copyWith(
            currentDish: _createDish(r),
            isLoading: true,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onDeleteDish(
    DeleteDish event,
    Emitter<EditDishState> emit,
  ) async {
    final dishId = state.data.currentDish?.id ?? -1;

    final response = await nutritionService.deleteDish(dishId);

    response.fold(
      (l) => emit(EditDishState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(const EditDishState.deleted(EditDishData(isLoading: false))),
    );
  }

  FutureOr<void> _onUpdateDish(
    UpdateDish event,
    Emitter<EditDishState> emit,
  ) async {
    emit(EditDishState.loading(state.data.copyWith(isLoading: true)));

    final dishId = state.data.currentDish?.id ?? -1;

    final data = UpdateDishBody(
      numberOfUnits: event.numberOfUnits,
      numberOfServings: event.numberOfServings,
      mealCategories: event.mealCategories,
      name: event.name,
    );

    final response = await nutritionService.updateDishById(dishId, data);

    response.fold(
      (l) => emit(EditDishState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(const EditDishState.saved(EditDishData(isLoading: false))),
    );
  }
}
