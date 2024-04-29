import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/dto/nutrition_instruction_value.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';

part 'nutrition_instructions_event.dart';
part 'nutrition_instructions_state.dart';
part 'nutrition_instructions_bloc.freezed.dart';
part 'nutrition_instructions_bloc.g.dart';

@singleton
class NutritionInstructionsBloc extends HydratedBloc<NutritionInstructionsEvent, NutritionInstructionsState> {
  final NutritionService nutritionService;

  NutritionInstructionsBloc(this.nutritionService)
      : super(const NutritionInstructionsState.initial(NutritionInstructionsData())) {
    on<FetchValuesExplanation>(_onFetchValuesExplanation);
  }

  FutureOr<void> _onFetchValuesExplanation(
    FetchValuesExplanation event,
    Emitter<NutritionInstructionsState> emit,
  ) async {
    emit(NutritionInstructionsState.loading(state.data.copyWith(isLoading: true, error: null)));

    final response = await nutritionService.getValuesExplanation();

    response.fold(
      (l) => emit(NutritionInstructionsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        NutritionInstructionValue possibleMinValue = r.data.first;

        NutritionInstructionValue possibleMaxValue = r.data.first;

        emit(
          NutritionInstructionsState.loaded(state.data.copyWith(
            calorieDensityValues: r.data,
            proteinDegreeValues: r.data,
            minCalorieDegreeValue: possibleMinValue,
            maxCalorieDegreeValue: possibleMaxValue,
            proteinDegreeValue: 0.0,
            calorieDensityValue: 0.0,
            isLoading: false,
          )),
        );
      },
    );
  }

  @override
  NutritionInstructionsState? fromJson(Map<String, dynamic> json) =>
      NutritionInstructionsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(NutritionInstructionsState state) {
    return state.toJson();
  }
}
