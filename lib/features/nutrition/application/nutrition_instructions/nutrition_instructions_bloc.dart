import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/dto/nutrition_instruction_value.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_instructions/nutrition_instruction_category.dart';

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
        final calorieDensityValues =
            r.data.where((el) => el.category == NutritionInstructionCategory.calorieDensity.name).toList();
        final proteinDegreeValues =
            r.data.where((el) => el.category == NutritionInstructionCategory.proteinDegree.name).toList();

        NutritionInstructionValue possibleMinValue = calorieDensityValues
            .reduce((a, b) => double.parse(a.minValue) < double.parse(b.minValue) ? a : b);

        NutritionInstructionValue possibleMaxValue = calorieDensityValues
            .reduce((a, b) => double.parse(a.maxValue) > double.parse(b.maxValue) ? a : b);

        emit(
          NutritionInstructionsState.loaded(state.data.copyWith(
            calorieDensityValues: calorieDensityValues,
            proteinDegreeValues: proteinDegreeValues,
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
