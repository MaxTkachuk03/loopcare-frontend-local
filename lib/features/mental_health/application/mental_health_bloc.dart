import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/mental_health/application/dto/answers_body.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_service.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_answer.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_question.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_test.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_test_type.dart';
import 'package:loopcare_frontend/features/mental_health/domain/test_result.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

part 'mental_health_bloc.freezed.dart';

part 'mental_health_event.dart';

part 'mental_health_state.dart';

@singleton
class MentalHealthBloc extends Bloc<MentalHealthEvent, MentalHealthState> {
  final MentalHealthService _mentalHealthService;
  final OnboardingBloc _onboardingBloc;

  MentalHealthBloc(this._mentalHealthService, this._onboardingBloc)
      : super(const MentalHealthState.initial(MentalHealthData())) {
    on<_GetMentalHealthTests>(_onGetMentalHealthTests);
    on<_NextTest>(_onNextTest);
    on<_PrevTest>(_onPrevTest);
    on<_PrevQuestion>(_onPrevQuestion);
    on<_NextQuestion>(_onNextQuestion);
    on<_SetAnswer>(_onSetAnswer);
    on<_GetTestResults>(_onGetTestResults);
    on<_SetCompleted>(_onSetCompleted);
    on<_SetStartTime>(_onSetStartTime);
    on<_StartTestFromBeginning>(_onStartTestFromBeginning);
  }

  FutureOr<void> _onGetMentalHealthTests(event, Emitter<MentalHealthState> emit) async {
    final response = await _mentalHealthService.mentalHealthQuestions();

    response.fold(
      (l) => null,
      (r) {
        final questionsListId = r.data.map((e) => e.questions.map((e) => e.id)).flattened.toList();
        emit(
          MentalHealthState.mentalHealthTests(
            state.data.copyWith(
              tests: r.data,
              questionsListId: questionsListId,
              totalQuestionsLength: questionsListId.length,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onNextTest(_NextTest event, Emitter<MentalHealthState> emit) {
    emit(
      MentalHealthState.mentalHealthTests(
        state.data.copyWith(
          currentQuestionIndex: 0,
          currentTestIndex: state.data.currentTestIndex + 1,
        ),
      ),
    );
  }

  FutureOr<void> _onPrevTest(_PrevTest event, Emitter<MentalHealthState> emit) {
    if (state.data.isFirstTest) return null;

    final prevTestIndex = state.data.currentTestIndex - 1;
    final lastQuestionIndexInPrevTest = state.data.tests[prevTestIndex].questions.length - 1;

    emit(
      MentalHealthState.mentalHealthTests(
        state.data.copyWith(
          currentTestIndex: state.data.currentTestIndex - 1,
          currentQuestionIndex: lastQuestionIndexInPrevTest,
        ),
      ),
    );
  }

  FutureOr<void> _onPrevQuestion(_PrevQuestion event, Emitter<MentalHealthState> emit) {
    if (state.data.isFirstQuestion) return null;

    emit(
      MentalHealthState.mentalHealthTests(
        state.data.copyWith(
          currentQuestionIndex: state.data.currentQuestionIndex - 1,
        ),
      ),
    );

    _onboardingBloc.add(
      OnboardingEvent.currentStepChanged(
        progress: state.data.progressPercentage,
        questionIndex: state.data.currentQuestionIndex,
      ),
    );
  }

  FutureOr<void> _onNextQuestion(_NextQuestion event, Emitter<MentalHealthState> emit) {
    emit(
      MentalHealthState.mentalHealthTests(
        state.data.copyWith(
          currentQuestionIndex: state.data.currentQuestionIndex + 1,
        ),
      ),
    );

    _onboardingBloc.add(
      OnboardingEvent.currentStepChanged(
        progress: state.data.progressPercentage,
        questionIndex: state.data.currentQuestionIndex,
      ),
    );
  }

  FutureOr<void> _onSetAnswer(_SetAnswer event, Emitter<MentalHealthState> emit) {
    var newAnswers = [...state.data.answers];
    var existingQuestionIndex =
        newAnswers.indexWhere((element) => element.questionId == event.answer.questionId);

    if (existingQuestionIndex.isNegative) {
      newAnswers = [...state.data.answers, event.answer];
    } else {
      newAnswers[existingQuestionIndex] = event.answer;
    }

    emit(
      MentalHealthState.mentalHealthTests(
        state.data.copyWith(answers: newAnswers),
      ),
    );
  }

  FutureOr<void> _onGetTestResults(_GetTestResults event, Emitter<MentalHealthState> emit) async {
    final currentTest = state.data.currentTest;

    if (currentTest == null) return;

    emit(MentalHealthState.loading(state.data.copyWith(isLoading: true)));

    final answers = state.data.isLastTest && state.data.isCompleted
        ? state.data.answers
        : currentTest.questions
            .map(
              (e) {
                return state.data.answers.firstWhereOrNull((element) => element.questionId == e.id);
              },
            )
            .whereType<MentalHealthAnswer>()
            .toList();

    final response = await _mentalHealthService.getTestResults(AnswersBody(answers: answers));

    response.fold(
      (e) => emit(MentalHealthState.loading(state.data.copyWith(isLoading: false, error: e))),
      (r) {
        emit(
          MentalHealthState.mentalHealthTests(
            state.data.copyWith(
              results: {
                ...state.data.results,
                currentTest.type: TestResult(
                  totalScore: r.totalScore,
                  interpretation: r.interpretation,
                )
              },
              isLoading: false,
              error: null,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onSetCompleted(event, Emitter<MentalHealthState> emit) {
    emit(MentalHealthState.mentalHealthTests(state.data.copyWith(isCompleted: event.value)));
  }

  FutureOr<void> _onSetStartTime(_SetStartTime event, Emitter<MentalHealthState> emit) {
    emit(MentalHealthState.mentalHealthTests(state.data.copyWith(startTestTime: event.time)));
  }

  FutureOr<void> _onStartTestFromBeginning(_StartTestFromBeginning event, Emitter<MentalHealthState> emit) {
    emit(MentalHealthState.mentalHealthTests(state.data.copyWith(
      startTestTime: null,
      results: {},
      answers: [],
      currentQuestionIndex: 0,
      currentTestIndex: 0,
    )));

    _onboardingBloc.add(
      const OnboardingEvent.currentStepChanged(
        progress: 0,
        questionIndex: 0,
      ),
    );
  }
}
