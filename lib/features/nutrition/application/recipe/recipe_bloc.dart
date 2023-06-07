import 'dart:async';
import 'package:loopcare_frontend/core/presentation/utils/double_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_food_item_to_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/update_food_item_in_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/update_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:rxdart/rxdart.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe/recipe.dart';

part 'recipe_event.dart';

part 'recipe_state.dart';

part 'recipe_bloc.freezed.dart';

@singleton
class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final NutritionService nutritionService;

  RecipeBloc(this.nutritionService) : super(const RecipeState.initial()) {
    on<FetchRecipe>(_onFetchRecipe);
    on<FetchRecipeFromMeal>(_onFetchRecipeFromMeal);
    on<NutritionItemChanged>(_onNutritionItemChanged);
    on<ServingChanged>(
      _onServingChanged,
      transformer: (events, mapper) => events
          .distinct()
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper),
    );
    on<AddFoodItemToRecipe>(_onAddFoodItemToRecipe);
    on<RemoveFoodItemToRecipe>(_onRemoveFoodItemToRecipe);
    on<UpdateFoodItemToRecipe>(_onUpdateFoodItemToRecipe);
  }

  FutureOr<void> _onFetchRecipe(
    FetchRecipe event,
    Emitter<RecipeState> emit,
  ) async {
    emit(const RecipeState.loading());

    final response = await nutritionService.getRecipe(event.id);

    response.fold(
      (error) {
        emit(RecipeState.error(error));
      },
      (response) {
        emit(
          RecipeState.recipeInfo(
            recipe: Recipe(
              id: response.id,
              externalId: response.externalId,
              ingredients: response.ingredients,
              calorieDensity: response.calorieDensity,
              proteinDegree: response.proteinDegree,
              nutritionValues: response.servingSize.list,
              numberOfServings: response.numberOfServings,
              servingAmount: response.servingSize.numberOfUnits,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onFetchRecipeFromMeal(
    FetchRecipeFromMeal event,
    Emitter<RecipeState> emit,
  ) async {
    emit(const RecipeState.loading());

    final response =
        await nutritionService.getRecipeInMeal(event.mealId, event.recipeId);

    response.fold(
      (error) {
        emit(RecipeState.error(error));
      },
      (response) {
        emit(
          RecipeState.recipeInfo(
            recipe: Recipe(
              id: response.id,
              externalId: response.externalId,
              ingredients: response.ingredients,
              calorieDensity: response.calorieDensity,
              proteinDegree: response.proteinDegree,
              nutritionValues: response.servingSize.list,
              numberOfServings: response.numberOfServings,
              servingAmount: response.servingSize.numberOfUnits,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onNutritionItemChanged(
    NutritionItemChanged event,
    Emitter<RecipeState> emit,
  ) {
    state.mapOrNull(recipeInfo: (state) {
      emit(state.copyWith(currentNutritionType: event.item));
    });
  }

  FutureOr<void> _onServingChanged(
    ServingChanged event,
    Emitter<RecipeState> emit,
  ) async {
    await state.mapOrNull(recipeInfo: (state) async {
      final response = await nutritionService.updateRecipeNumberOfServing(
        mealId: event.mealId,
        recipeId: event.recipeId,
        data: UpdateRecipeBody(numberOfUnits: event.servingAmount),
      );

      response.fold(
        (l) => null,
        (r) => emit(state.copyWith(
          recipe: Recipe(
            id: r.id,
            externalId: r.externalId,
            ingredients: r.ingredients,
            calorieDensity: r.calorieDensity,
            proteinDegree: r.proteinDegree,
            nutritionValues: r.servingSize.list,
            numberOfServings: r.numberOfServings,
            servingAmount: r.servingSize.numberOfUnits,
          ),
        )),
      );
    });
  }

  FutureOr<void> _onAddFoodItemToRecipe(
    AddFoodItemToRecipe event,
    Emitter<RecipeState> emit,
  ) async {
    await state.mapOrNull(recipeInfo: (state) async {
      final response = await nutritionService.addFoodItemToRecipeInMeal(
        mealId: event.mealId,
        recipeId: event.recipeId,
        foodItemId: event.foodItemId,
        data: AddFoodItemToRecipeBody(
          numberOfUnits: event.numberOfUnits,
          servingId: event.servingId,
        ),
      );

      response.fold(
        (l) => null,
        (r) {
          emit(
            state.copyWith(
              recipe: Recipe(
                id: r.id,
                externalId: r.externalId,
                ingredients: r.ingredients,
                calorieDensity: r.calorieDensity,
                proteinDegree: r.proteinDegree,
                nutritionValues: r.servingSize.list,
                numberOfServings: r.numberOfServings,
                servingAmount: r.servingSize.numberOfUnits,
              ),
            ),
          );
        },
      );
    });
  }

  FutureOr<void> _onRemoveFoodItemToRecipe(
    RemoveFoodItemToRecipe event,
    Emitter<RecipeState> emit,
  ) async {
    await state.mapOrNull(
      recipeInfo: (state) async {
        final response = await nutritionService.removeFoodItemFromRecipeInMeal(
          mealId: event.mealId,
          recipeId: event.recipeId,
          foodItemId: event.foodItemId,
        );

        response.fold(
          (l) => null,
          (r) {
            emit(
              state.copyWith(
                recipe: Recipe(
                  id: r.id,
                  externalId: r.externalId,
                  ingredients: r.ingredients,
                  calorieDensity: r.calorieDensity,
                  proteinDegree: r.proteinDegree,
                  nutritionValues: r.servingSize.list,
                  numberOfServings: r.numberOfServings,
                  servingAmount: r.servingSize.numberOfUnits,
                ),
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onUpdateFoodItemToRecipe(
    UpdateFoodItemToRecipe event,
    Emitter<RecipeState> emit,
  ) async {
    await state.mapOrNull(recipeInfo: (state) async {
      final response = await nutritionService.updateFoodItemInRecipeInMeal(
        mealId: event.mealId,
        recipeId: event.recipeId,
        foodItemId: event.foodItemId,
        data: UpdateFoodItemInRecipeBody(
          numberOfUnits: event.numberOfUnits,
          servingId: event.servingId,
        ),
      );

      response.fold(
        (l) => null,
        (r) {
          emit(
            state.copyWith(
              recipe: Recipe(
                  id: r.id,
                  externalId: r.externalId,
                  ingredients: r.ingredients,
                  calorieDensity: r.calorieDensity,
                  proteinDegree: r.proteinDegree,
                  nutritionValues: r.servingSize.list,
                  numberOfServings: r.numberOfServings,
                  servingAmount: r.servingSize.numberOfUnits),
            ),
          );
        },
      );
    });
  }
}
