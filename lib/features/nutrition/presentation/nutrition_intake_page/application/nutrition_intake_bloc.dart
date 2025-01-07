import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/dto/nutrition_intake_goal_progress/nutrition_intake_goal_progress.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/domain/nutrition_intake_services.dart';

part 'nutrition_intake_event.dart';

part 'nutrition_intake_state.dart';

part 'nutrition_intake_bloc.freezed.dart';

@singleton
class NutritionIntakeBloc extends Bloc<NutritionIntakeEvent, NutritionIntakeState> {
  final NutritionIntakeServices _nutritionIntakeServices;

  NutritionIntakeBloc(this._nutritionIntakeServices)
      : super(const NutritionIntakeState.initial(NutritionIntakeStateData())) {
    on<FetchProgress>(_onFetchProgress);
    on<CompleteDay>(_completeDay);
    on<FinishLesson>(_onFinishLesson);
    on<GetLessonId>(_onGetLessonId);
  }

  Future<void> _onFetchProgress(
    FetchProgress event,
    Emitter<NutritionIntakeState> emit,
  ) async {
    emit(NutritionIntakeState.loading(state.data.copyWith(isLoading: true)));

    final response = await _nutritionIntakeServices.getLessons(date: event.date);

    response.fold(
        (left) =>
            emit(NutritionIntakeState.error(state.data.copyWith(error: left, isLoading: false))),
        (right) {
      var sortedProgress = [...right.progress]..sort((a, b) => a.iLessonId.compareTo(b.iLessonId));

      emit(NutritionIntakeState.loaded(state.data.copyWith(
        isDayClosed: right.isDayClosed,
        progress: sortedProgress,
        isLoading: false,
      )));
    });
  }

  Future<void> _completeDay(
    CompleteDay event,
    Emitter<NutritionIntakeState> emit,
  ) async {
    await _nutritionIntakeServices.completeDay(date: event.date);

    emit(NutritionIntakeState.completeDay(
        state.data.copyWith(isDayClosed: true, dateTime: event.date.toLocal().toString())));
  }

  Future<void> _onGetLessonId(
    GetLessonId event,
    Emitter<NutritionIntakeState> emit,
  ) async {
    emit(NutritionIntakeState.loaded(state.data.copyWith(iLessonId: event.iLessonId)));
  }

  Future<void> _onFinishLesson(
    FinishLesson event,
    Emitter<NutritionIntakeState> emit,
  ) async {
    await _nutritionIntakeServices.finishLesson(
      date: event.date,
      iLessonId: event.iLessonId,
    );

    emit(NutritionIntakeState.finishLesson(state.data
        .copyWith(dateTime: event.date.toLocal().toString(), iLessonId: event.iLessonId)));
  }
}
