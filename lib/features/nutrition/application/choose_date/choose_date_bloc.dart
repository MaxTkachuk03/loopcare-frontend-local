import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';

part 'choose_date_event.dart';

part 'choose_date_state.dart';

part 'choose_date_bloc.freezed.dart';

@singleton
class ChooseDateBloc extends Bloc<ChooseDateEvent, ChooseDateState> {
  final NutritionService nutritionService;

  ChooseDateBloc(this.nutritionService) : super(const ChooseDateState.initial(ChooseDateData())) {
    on<FetchInit>(_onFetchRecipe);
    on<SetData>(_onSetData);
    // on<NutritionItemChanged>(_onNutritionItemChanged);
    // on<ServingChanged>(
    //   _onServingChanged,
    //   transformer: (events, mapper) =>
    //       events.distinct().debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    // );
    // on<AddFoodItemToRecipe>(_onAddFoodItemToRecipe);
    // on<RemoveFoodItemToRecipe>(_onRemoveFoodItemToRecipe);
    // on<UpdateFoodItemToRecipe>(_onUpdateFoodItemToRecipe);
  }
  FutureOr<void> _onSetData(
    SetData event,
    Emitter<ChooseDateState> emit,
  ) async {
    emit(
      ChooseDateState.calendar(
        state.data.copyWith(
          mealCategory: event.mealCategory,
          date: event.date,
        ),
      ),
    );
  }

  FutureOr<void> _onFetchRecipe(
    FetchInit event,
    Emitter<ChooseDateState> emit,
  ) async {
    emit(
      ChooseDateState.loading(
        state.data.copyWith(
          error: null,
        ),
      ),
    );

    final response = await nutritionService.getRecipe(event.id);

    response.fold(
      (error) => emit(
        ChooseDateState.error(
          state.data.copyWith(
            error: error,
          ),
        ),
      ),
      (response) {
        // emit(
        //   ChooseDateState.recipeInfo(
        //     recipe: Recipe(
        //       id: response.id,
        //       externalId: response.externalId,
        //       ingredients: response.ingredients,
        //       calorieDensity: response.calorieDensity,
        //       proteinDegree: response.proteinDegree,
        //       nutritionValues: response.servingSize.list,
        //       numberOfServings: response.numberOfServings,
        //       servingAmount: response.servingSize.numberOfUnits,
        //     ),
        //   ),
        // );
      },
    );
  }
}
