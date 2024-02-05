import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
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
        final lessonWithCountdown = event.category == LessonCategory.all
            ? _getLessonWithCountdown(r.lessons)
            : state.data.lessonWithCountdown;

        emit(
          EducationProgramState.educationProgram(
            state.data.copyWith(
              currentCategory: event.category,
              isLoading: false,
              lessons: r.lessons,
              lessonWithCountdown: lessonWithCountdown,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onResetLessonWithCountdown(event, Emitter<EducationProgramState> emit) async {
    emit(EducationProgramState.educationProgram(state.data.copyWith(lessonWithCountdown: null)));
  }

  LessonWithCountdown? _getLessonWithCountdown(List<EducationLesson> lessons) {
    final lastCompletedLesson = lessons.lastWhereOrNull((element) => element.completedAt != null);
    final currentActiveStep = lastCompletedLesson?.step;
    final startDate = lastCompletedLesson?.completedAt?.toLocal();

    if (currentActiveStep == null || startDate == null) return null;

    final lessonWithCountdown = lessons.firstWhereOrNull((element) => element.step == currentActiveStep + 1);

    if (lessonWithCountdown == null) return null;

    final nextStepUnlockDelayInHours =
        lessons.where((l) => l.step == currentActiveStep).last.nextStepUnlockDelay;

    final dateTimeLessonShouldBeUnlocked =
        startDate.toLocal().add(Duration(hours: nextStepUnlockDelayInHours));

    return LessonWithCountdown(
        dateTimeWhenUnlock: dateTimeLessonShouldBeUnlocked, lesson: lessonWithCountdown);
  }
}
