import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/time_service/time_service.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';
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
    on<_SetLessonWithCountdown>(_onSetLessonWithCountdown);
  }

  Future<void> _onGetLessons(_GetLessons event, Emitter<EducationProgramState> emit) async {
    emit(
      EducationProgramState.loading(
        state.data.copyWith(currentCategory: event.category, isLoading: true, error: null),
      ),
    );

    final response = await _educationService.getLessons(event.category);

    response.fold(
      (l) => emit(EducationProgramState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) {
        emit(
          EducationProgramState.educationProgram(
            state.data.copyWith(
              currentCategory: event.category,
              isLoading: false,
              lessons: r.lessons,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onSetLessonWithCountdown(
      _SetLessonWithCountdown event, Emitter<EducationProgramState> emit) async {
    if (event.category == LessonCategory.all) {
      emit(EducationProgramState.educationProgram(
          state.data.copyWith(lessonWithCountdown: state.data.lessonWithCountdown)));
    }

    final lastCompletedLesson = state.data.lessons.lastWhereOrNull((element) => element.completedAt != null);

    final currentActiveStep = lastCompletedLesson?.step;

    if (currentActiveStep == null) {
      emit(EducationProgramState.educationProgram(state.data.copyWith(lessonWithCountdown: null)));
      return;
    }

    final lessonsWithSameStep = state.data.lessons.where((l) => l.step == currentActiveStep);

    final startDate = lessonsWithSameStep.first.completedAt?.toLocal();

    if (startDate == null) {
      emit(EducationProgramState.educationProgram(state.data.copyWith(lessonWithCountdown: null)));
      return;
    }

    final lessonWithCountdown =
        state.data.lessons.firstWhereOrNull((element) => element.step == currentActiveStep + 1);

    if (lessonWithCountdown == null) {
      emit(EducationProgramState.educationProgram(state.data.copyWith(lessonWithCountdown: null)));
      return;
    }

    final nextStepUnlockDelayInHours = lessonsWithSameStep.last.nextStepUnlockDelay;

    final currentNtpDate = await TimeService.now;

    final timeRemaining =
        startDate.add(Duration(hours: nextStepUnlockDelayInHours)).difference(currentNtpDate).inSeconds;

    if (timeRemaining <= 0) {
      emit(EducationProgramState.educationProgram(state.data.copyWith(lessonWithCountdown: null)));
      return;
    }

    emit(
      EducationProgramState.educationProgram(
        state.data.copyWith(
          lessonWithCountdown: LessonWithCountdown(timeRemaining: timeRemaining, lesson: lessonWithCountdown),
        ),
      ),
    );
  }

  FutureOr<void> _onResetLessonWithCountdown(event, Emitter<EducationProgramState> emit) async {
    emit(EducationProgramState.educationProgram(state.data.copyWith(lessonWithCountdown: null)));
  }
}
