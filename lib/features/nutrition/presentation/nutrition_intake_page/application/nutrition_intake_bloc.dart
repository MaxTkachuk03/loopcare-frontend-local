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
    on<ResetSurvey>(_onResetSurvey);
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
    emit(NutritionIntakeState.completeDay(state.data.copyWith(isDayClosed: true)));

    await _nutritionIntakeServices.completeDay(date: event.date);
  }

  Future<void> _onFinishLesson(
    FinishLesson event,
    Emitter<NutritionIntakeState> emit,
  ) async {
    final lessonToUpdate =
        state.data.progress.where((lesson) => lesson.iLessonId == event.iLessonId).toList().first;

    final NutritionIntakeGoalProgress lessonWithProgress =
        lessonToUpdate.copyWith(isLessonFinished: true);

    final updatedLessons = {for (var item in state.data.progress) item.iLessonId: item};

    updatedLessons.updateAll((key, lesson) {
      if (lesson.iLessonId == event.iLessonId) {
        return lessonWithProgress;
      }
      return lesson;
    });

    final updatedLessonsList = updatedLessons.values.toList();

    emit(NutritionIntakeState.finishLesson(state.data.copyWith(
      progress: updatedLessonsList,
    )));

    await _nutritionIntakeServices.finishLesson(
      date: event.date,
      iLessonId: event.iLessonId,
    );
  }

  Future<void> _onResetSurvey(
    ResetSurvey event,
    Emitter<NutritionIntakeState> emit,
  ) async {
    emit(NutritionIntakeState.loaded(state.data.copyWith(
      isDayClosed: false,
      progress: [],
      isLoading: false,
    )));
  }
}
