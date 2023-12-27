import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/presentation/utils/list_extensions.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/questions/lesson_answer_body.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';

part 'assignments_bloc.freezed.dart';
part 'assignments_event.dart';
part 'assignments_state.dart';

@singleton
class AssignmentsBloc extends Bloc<AssignmentsEvent, AssignmentsState> {
  final EducationService _educationService;

  AssignmentsBloc(
    this._educationService,
  ) : super(const AssignmentsState.initial(AssignmentsStateData())) {
    on<GetLessonQuestions>(_onGetLessonQuestions);
    on<SaveLessonAnswerText>(_onSaveLessonAnswerText);
    on<UpdateLessonAnswerText>(_onUpdateLessonAnswerText);
    on<SaveLessonAnswerOption>(_onSaveLessonAnswerOption);
    on<UpdateLessonAnswerOption>(_onUpdateLessonAnswerOption);
    on<GetAllLessonQuestions>(_onGetAllLessonQuestions);
  }

  FutureOr<void> _onGetAllLessonQuestions(
    GetAllLessonQuestions event,
    Emitter<AssignmentsState> emit,
  ) async {
    emit(AssignmentsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _educationService.getAllLessonQuestions(
      event.startDate.toIso8601String(),
      event.endDate.toIso8601String(),
    );

    response.fold(
      (l) => emit(
        AssignmentsState.error(state.data.copyWith(
          error: l,
          isLoading: false,
        )),
      ),
      (r) {
        final questions = r.data;
        questions.sort((a, b) => a.id.compareTo(b.id));

        emit(
          AssignmentsState.updated(
            state.data.copyWith(
              questions: questions,
              isLoading: false,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onSaveLessonAnswerOption(
    SaveLessonAnswerOption event,
    Emitter<AssignmentsState> emit,
  ) async {
    emit(AssignmentsState.loading(state.data.copyWith(isLoading: true)));

    LessonAnswerOptionBody data = LessonAnswerOptionBody(
      lessonQuestionOptionIds: event.lessonQuestionOptionIds,
    );

    final response = await _educationService.saveLessonAnswerOption(event.lessonQuestionId, data);

    response.fold(
      (l) => emit(
        AssignmentsState.error(state.data.copyWith(
          error: l,
          isLoading: false,
        )),
      ),
      (r) {
        emit(
          AssignmentsState.updated(
            state.data.copyWith(
              isLoading: false,
              questions: _updatedQuestions(r),
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onUpdateLessonAnswerOption(
    UpdateLessonAnswerOption event,
    Emitter<AssignmentsState> emit,
  ) async {
    emit(AssignmentsState.loading(state.data.copyWith(isLoading: true)));

    LessonAnswerOptionBody data = LessonAnswerOptionBody(
      lessonQuestionOptionIds: event.lessonQuestionOptionIds,
    );

    final response = await _educationService.updateLessonAnswerOption(event.lessonQuestionId, data);

    response.fold(
      (l) => emit(
        AssignmentsState.error(state.data.copyWith(
          error: l,
          isLoading: false,
        )),
      ),
      (r) {
        emit(
          AssignmentsState.updated(
            state.data.copyWith(
              isLoading: false,
              questions: _updatedQuestions(r),
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onSaveLessonAnswerText(
    SaveLessonAnswerText event,
    Emitter<AssignmentsState> emit,
  ) async {
    emit(AssignmentsState.loading(state.data.copyWith(isLoading: true)));

    LessonAnswerTextBody data = LessonAnswerTextBody(
      text: event.text,
    );

    final response = await _educationService.saveLessonAnswerText(event.lessonQuestionId, data);

    response.fold(
      (l) => emit(
        AssignmentsState.error(state.data.copyWith(
          error: l,
          isLoading: false,
        )),
      ),
      (r) {
        emit(
          AssignmentsState.updated(
            state.data.copyWith(
              isLoading: false,
              questions: _updatedQuestions(r),
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onUpdateLessonAnswerText(
    UpdateLessonAnswerText event,
    Emitter<AssignmentsState> emit,
  ) async {
    emit(AssignmentsState.loading(state.data.copyWith(isLoading: true)));

    LessonAnswerTextBody data = LessonAnswerTextBody(
      text: event.text,
    );

    final response = await _educationService.updateLessonAnswerText(event.lessonQuestionId, data);

    response.fold(
      (l) => emit(
        AssignmentsState.error(state.data.copyWith(
          error: l,
          isLoading: false,
        )),
      ),
      (r) {
        emit(
          AssignmentsState.updated(
            state.data.copyWith(
              isLoading: false,
              questions: _updatedQuestions(r),
            ),
          ),
        );
      },
    );
  }

  List<LessonQuestion> _updatedQuestions(
    LessonQuestion data,
  ) {
    List<LessonQuestion> retData = List<LessonQuestion>.from(state.data.questions);

    final int index = retData.indexWhere((el) => el.id == data.id);
    if (index >= 0) retData.update(index, data);

    return retData;
  }

  FutureOr<void> _onGetLessonQuestions(
    GetLessonQuestions event,
    Emitter<AssignmentsState> emit,
  ) async {
    emit(AssignmentsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _educationService.getLessonContent(event.lessonId);

    response.fold(
      (l) => emit(
        AssignmentsState.error(state.data.copyWith(
          error: l,
          isLoading: false,
        )),
      ),
      (r) {
        final questions = r.questions;
        questions.sort((a, b) => a.id.compareTo(b.id));

        emit(
          AssignmentsState.updated(state.data.copyWith(
            lessonId: event.lessonId,
            questions: questions,
          )),
        );
      },
    );
  }
}
