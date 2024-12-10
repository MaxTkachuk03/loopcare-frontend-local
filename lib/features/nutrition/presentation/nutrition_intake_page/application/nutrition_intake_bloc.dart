import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/dto/nutrition_intake_done_lessons/nutrition_intake_done_lessons.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/domain/nutrition_intake_services.dart';

part 'nutrition_intake_event.dart';
part 'nutrition_intake_state.dart';
part 'nutrition_intake_bloc.freezed.dart';

@singleton
class NutritionIntakeBloc extends Bloc<NutritionIntakeEvent, NutritionIntakeState> {
  final NutritionIntakeServices _nutritionIntakeServices;

  NutritionIntakeBloc(this._nutritionIntakeServices)
      : super(const NutritionIntakeState.initial(NutritionIntakeStateData())) {
    on<FetchProgress>(_onGetProgress);
    on<CloseDay>(_closeDay);
  }

  Future<void> _onGetProgress(
    FetchProgress event,
    Emitter<NutritionIntakeState> emit,
  ) async {
    emit(NutritionIntakeState.loading(state.data.copyWith(isLoading: true)));

    final response = await _nutritionIntakeServices.getLessons(date: event.date);

    response.fold(
        (left) =>
            emit(NutritionIntakeState.error(state.data.copyWith(error: left, isLoading: false))),
        (right) => emit(NutritionIntakeState.loaded(state.data.copyWith(
            isDayClosed: right.isDayClosed, progress: right.progress, isLoading: false))));
  }

  Future<void> _closeDay(
    CloseDay event,
    Emitter<NutritionIntakeState> emit,
  ) async {
    await _nutritionIntakeServices.closeDay(isDayClosed: event.isDayClosed);

    emit(NutritionIntakeState.closeDay(state.data.copyWith(isDayClosed: event.isDayClosed)));
  }
}
