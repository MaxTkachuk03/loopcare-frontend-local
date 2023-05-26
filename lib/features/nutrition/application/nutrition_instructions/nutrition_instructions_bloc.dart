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

      NutritionInstructionValue possibleMinValue = calorieDensityValues.reduce(
          (a, b) =>
              double.parse(a.minValue) < double.parse(b.minValue) ? a : b);

      NutritionInstructionValue possibleMaxValue = calorieDensityValues.reduce(
          (a, b) =>
              double.parse(a.maxValue) > double.parse(b.maxValue) ? a : b);

      emit(
        NutritionInstructionsState.nutritionInstructions(
          calorieDensityValues: calorieDensityValues,
          proteinDegreeValues: proteinDegreeValues,
          minCalorieDegreeValue: possibleMinValue,
          maxCalorieDegreeValue: possibleMaxValue,
          proteinDegreeValue: 0.0,
          calorieDensityValue: 0.0,
          isDisabled: false,
        ),
      );
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
