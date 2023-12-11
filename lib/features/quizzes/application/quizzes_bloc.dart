import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/list_extensions.dart';
import 'package:loopcare_frontend/features/education/application/education_service.dart';
import 'package:loopcare_frontend/features/education/domain/questions/lesson_answer_body.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';

part 'quizzes_bloc.freezed.dart';
part 'quizzes_event.dart';
part 'quizzes_state.dart';

@singleton
class QuizzesBloc extends Bloc<QuizzesEvent, QuizzesState> {
  final EducationService _educationService;

  QuizzesBloc(
    this._educationService,
  ) : super(const QuizzesState.initial(QuizzesStateData())) {
    on<GetLessonQuizzes>(_onGetLessonQuizzes);

    on<SaveLessonAnswer>(_onSaveLessonAnswer);
  }

  FutureOr<void> _onSaveLessonAnswer(
    SaveLessonAnswer event,
    Emitter<QuizzesState> emit,
  ) async {
    emit(QuizzesState.loading(state.data.copyWith(isLoading: true)));

    LessonAnswerOptionBody data = LessonAnswerOptionBody(
      lessonQuestionOptionIds: event.lessonQuestionOptionIds,
    );
    final response = await _educationService.saveLessonAnswerOption(event.lessonQuestionId, data);

    response.fold(
      (l) => emit(QuizzesState.error(state.data.copyWith(
        error: l,
        isLoading: false,
      ))),
      (r) {
        emit(
          QuizzesState.updated(
            state.data.copyWith(
              isLoading: false,
              quizzes: _updatedQuestions(r),
            ),
          ),
        );
      },
    );
  }

  List<LessonQuestion> _updatedQuestions(
    LessonQuestion data,
  ) {
    List<LessonQuestion> retData = List<LessonQuestion>.from(state.data.quizzes);

    final int index = retData.indexWhere((el) => el.id == data.id);
    if (index >= 0) retData.update(index, data);

    return retData;
  }

  FutureOr<void> _onGetLessonQuizzes(
    GetLessonQuizzes event,
    Emitter<QuizzesState> emit,
  ) async {
    emit(QuizzesState.loading(state.data.copyWith(isLoading: true)));

    final response = await _educationService.getLessonContent(event.lessonId);

    response.fold(
      (l) => emit(QuizzesState.error(state.data.copyWith(
        error: l,
        isLoading: false,
      ))),
      (r) => emit(QuizzesState.updated(state.data.copyWith(
        lessonId: event.lessonId,
        quizzes: r.questions,
      ))),
    );
  }
}
