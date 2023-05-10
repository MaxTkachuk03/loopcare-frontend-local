import 'dart:async';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_details/recipe_details.dart';

part 'recipe_details_event.dart';

part 'recipe_details_state.dart';

part 'recipe_details_bloc.freezed.dart';

@singleton
class RecipeDetailsBloc extends Bloc<RecipeDetailsEvent, RecipeDetailsState> {
  final NutritionService nutritionService;

  RecipeDetailsBloc(this.nutritionService)
      : super(const RecipeDetailsState.initial()) {
    on<FetchOriginRecipe>(_onFetchOriginRecipe);
    on<NutritionItemChanged>(_onNutritionItemChanged);
  }

  FutureOr<void> _onFetchOriginRecipe(
    FetchOriginRecipe event,
    Emitter<RecipeDetailsState> emit,
  ) async {
    emit(const RecipeDetailsState.loading());

    final response = await nutritionService.getRecipe(event.id);

    response.fold(
      (error) {
        emit(RecipeDetailsState.error(error));
      },
      (response) {
        emit(
          RecipeDetailsState.recipeInfo(
            recipe: RecipeDetails(
              id: response.id,
              ingredients: response.ingredients,
              calorieDensity: response.calorieDensity,
              proteinDegree: response.proteinDegree,
              nutritionValues: response.servingSize.list,
              numberOfServings: response.numberOfServings,
              servingAmount: response.servingSize.numberOfUnits,
              name: response.name,
              cookingTimeMin: response.cookingTimeMin,
              preparationTimeMin: response.preparationTimeMin,
              description: response.description,
              directions: response.directions,
            ),
            currentRecipeNutritionItem: response.servingSize.list.firstWhere(
                (element) => element.key == NutritionValuesTypes.calories.name),
          ),
        );
      },
    );
  }

  FutureOr<void> _onNutritionItemChanged(
    NutritionItemChanged event,
    Emitter<RecipeDetailsState> emit,
  ) {
    state.mapOrNull(recipeInfo: (state) {
      emit(state.copyWith(currentRecipeNutritionItem: event.item));
    });
  }
}
