import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/time_service/time_service.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_with_countdown.dart';

part 'education_program_bloc.freezed.dart';
part 'education_program_event.dart';
part 'education_program_state.dart';

@singleton
class EducationProgramBloc extends Bloc<EducationProgramEvent, EducationProgramState> {
  final EducationService _educationService;

  EducationProgramBloc(this._educationService)
      : super(const EducationProgramState.initial(EducationProgramData())) {
    on<_GetLessons>(_onGetLessons);
    on<_ResetLessonWithCountdown>(_onResetLessonWithCountdown);
  }

  Future<void> _onGetLessons(_GetLessons event, Emitter<EducationProgramState> emit) async {
    emit(EducationProgramState.loading(state.data.copyWith(isLoading: true, error: null)));
    final response = await _educationService.getLessons();
    final currentNtpDate = await TimeService.now;

    response.fold(
      (l) => emit(EducationProgramState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) {
        final lessonWithCountdown = _onCalculateCountdown(currentNtpDate, r.lessons);
        emit(EducationProgramState.educationProgram(state.data
            .copyWith(isLoading: false, lessons: r.lessons, lessonWithCountdown: lessonWithCountdown)));
        emit(EducationProgramState.loaded(state.data.copyWith(isLoading: true, error: null)));
      },
    );
  }

  LessonWithCountdown? _onCalculateCountdown(DateTime currentNtpDate, List<EducationLesson> lessons) {
    final lastCompletedLesson = lessons.lastWhereOrNull((element) => element.completedAt != null);
    if (lastCompletedLesson == null) {
      return null;
    }

    final currentActiveStep = lastCompletedLesson.step;

    if (currentActiveStep == null) {
      return null;
    }

    final lessonsWithSameStep = lessons.where((l) => l.step == currentActiveStep);

    final startDate = lessonsWithSameStep.first.completedAt?.toLocal();
    if (startDate == null) {
      return null;
    }

    final lessonWithCountdown = lessons.firstWhereOrNull((element) => element.step == currentActiveStep + 1);
    if (lessonWithCountdown == null) {
      return null;
    }

    final nextStepUnlockDelayInHours = lessonsWithSameStep.last.unlockingConfig.nextStepUnlockDelay;

    final timeRemaining =
        startDate.add(Duration(hours: nextStepUnlockDelayInHours)).difference(currentNtpDate).inSeconds;
    if (timeRemaining <= 0) {
      return null;
    }
    return LessonWithCountdown(timeRemaining: timeRemaining, lesson: lessonWithCountdown);
  }

  FutureOr<void> _onResetLessonWithCountdown(event, Emitter<EducationProgramState> emit) async {
    emit(EducationProgramState.educationProgram(
        state.data.copyWith(isLoading: false, lessonWithCountdown: null)));
  }
}
