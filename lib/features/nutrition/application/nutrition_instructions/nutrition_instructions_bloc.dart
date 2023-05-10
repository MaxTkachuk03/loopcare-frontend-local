import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/dto/nutrition_instruction_value.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_instructions/nutrition_instruction_category.dart';

part 'nutrition_instructions_event.dart';

part 'nutrition_instructions_state.dart';

part 'nutrition_instructions_bloc.freezed.dart';

@singleton
class NutritionInstructionsBloc
    extends Bloc<NutritionInstructionsEvent, NutritionInstructionsState> {
  final NutritionService nutritionService;

  NutritionInstructionsBloc(this.nutritionService)
      : super(const NutritionInstructionsState.initial()) {
    on<FetchValuesExplanation>(_onFetchValuesExplanation);
    on<SetCalorieDensity>(_onSetCalorieDensity);
    on<SetProteinDegree>(_onSetProteinDegree);
    on<Disable>(_onDisable);
  }

  FutureOr<void> _onFetchValuesExplanation(
    FetchValuesExplanation event,
    Emitter<NutritionInstructionsState> emit,
  ) async {
    final response = await nutritionService.getValuesExplanation();

    response.fold((l) => null, (r) {
      final calorieDensityValues = r.data
          .where((el) =>
              el.category == NutritionInstructionCategory.calorieDensity.name)
          .toIList();
      final proteinDegreeValues = r.data
          .where((el) =>
              el.category == NutritionInstructionCategory.proteinDegree.name)
          .toIList();

      emit(
        NutritionInstructionsState.nutritionInstructions(
          calorieDensityValues: calorieDensityValues,
          proteinDegreeValues: proteinDegreeValues,
          proteinDegreeValue: 0.0,
          calorieDensityValue: 0.0,
          isDisabled: false,
        ),
      );
    });
  }

  _onSetCalorieDensity(
    SetCalorieDensity event,
    Emitter<NutritionInstructionsState> emit,
  ) {
    state.mapOrNull(nutritionInstructions: (state) {
      emit(state.copyWith(
        calorieDensityValue: double.parse(event.value.toStringAsFixed(2)),
        isDisabled: false,
      ));
    });
  }

  _onSetProteinDegree(
    SetProteinDegree event,
    Emitter<NutritionInstructionsState> emit,
  ) {
    state.mapOrNull(nutritionInstructions: (state) {
      emit(state.copyWith(
          proteinDegreeValue: double.parse(event.value.toStringAsFixed(2))));
    });
  }

  FutureOr<void> _onDisable(
    Disable event,
    Emitter<NutritionInstructionsState> emit,
  ) {
    state.mapOrNull(nutritionInstructions: (state) {
      emit(state.copyWith(
        isDisabled: true,
      ));
    });
  }
}
