import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/nutrition_value.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';

part 'nutrition_event.dart';
part 'nutrition_state.dart';
part 'nutrition_bloc.freezed.dart';

@singleton
class NutritionBloc extends Bloc<NutritionEvent, NutritionState> {
  final NutritionService nutritionService;

  NutritionBloc(this.nutritionService) : super(NutritionState.initial()) {
    on<FetchValuesExplanation>(_onFetchValuesExplanation);
  }

  FutureOr<void> _onFetchValuesExplanation(
    FetchValuesExplanation event,
    Emitter<NutritionState> emit,
  ) async {
    final response = await nutritionService.getValuesExplanation();

    response.fold((l) => null, (r) {
      final calorieDensityValues =
          r.data.where((el) => el.category == 'calorie density').toIList();
      final proteinDegreeValues =
          r.data.where((el) => el.category == 'protein degree').toIList();

      emit(
        state.copyWith(
          calorieDensityValues: calorieDensityValues,
          proteinDegreeValues: proteinDegreeValues,
        ),
      );
    });
  }
}
