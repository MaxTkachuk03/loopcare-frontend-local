import 'dart:async';
import 'package:collection/collection.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/mental_health/application/dto/answers_body.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_service.dart';
import 'package:loopcare_frontend/features/mental_health/domain/interpretation_type.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_answer.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_question.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_test.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_test_type.dart';
import 'package:loopcare_frontend/features/mental_health/domain/test_result.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/application/physical_fitness_bloc.dart';

part 'mental_health_bloc.freezed.dart';

part 'mental_health_bloc.g.dart';

part 'mental_health_event.dart';

part 'mental_health_state.dart';

@singleton
class MentalHealthBloc extends HydratedBloc<MentalHealthEvent, MentalHealthState> {
  final MentalHealthService _mentalHealthService;
  final OnboardingBloc _onboardingBloc;
  final PhysicalFitnessBloc _physicalFitnessBloc;
  final AuthenticationCubit _authenticationCubit;

  late final StreamSubscription _authBlocStreamSubscription;

  MentalHealthBloc(
    this._mentalHealthService,
    this._onboardingBloc,
    this._physicalFitnessBloc,
    this._authenticationCubit,
  ) : super(MentalHealthState.initial()) {
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
    on<_NextPage>(_onNextPage);
    on<_PrevPage>(_onPrevPage);
    on<_ResetData>(_onResetData);

    _authBlocStreamSubscription = _authenticationCubit.stream.distinct().listen((s) {
      s.mapOrNull(
        authenticated: (_) {
          add(const MentalHealthEvent.resetData());
        },
      );
    });
  }

  @override
  Future<void> close() async {
    _authBlocStreamSubscription.cancel();

    return super.close();
  }

  FutureOr<void> _onGetMentalHealthTests(event, Emitter<MentalHealthState> emit) async {
    emit(state.copyWith(
      data: state.data.copyWith(
        isLoading: true,
        error: null,
      ),
    ));

    final response = await _mentalHealthService.mentalHealthQuestions();

    response.fold(
      (e) => emit(
        state.copyWith(
          data: state.data.copyWith(error: e, isLoading: false),
        ),
      ),
      (r) {
        final selectedGender = _physicalFitnessBloc.state.sexType;

        if (selectedGender == null) return null;

        final testsWithGenderExclusions = r.data
            .map((element) => element.copyWith(
                questions: element.questions.where((e) => e.excludeGender != selectedGender).toList()))
            .toList();

        final questionsListId =
            testsWithGenderExclusions.map((e) => e.questions.map((e) => e.id)).flattened.toList();

        emit(state.copyWith(
          data: state.data.copyWith(
            isLoading: false,
            tests: testsWithGenderExclusions,
            questionsListId: questionsListId,
            totalQuestionsLength: questionsListId.length,
          ),
        ));
      },
    );
  }

  FutureOr<void> _onNextTest(_NextTest event, Emitter<MentalHealthState> emit) {
    emit(state.copyWith(
      data: state.data.copyWith(
        currentQuestionIndex: 0,
        currentTestIndex: state.data.currentTestIndex + 1,
      ),
    ));
  }

  FutureOr<void> _onPrevTest(_PrevTest event, Emitter<MentalHealthState> emit) {
    if (state.data.isFirstTest) return null;

    final prevTestIndex = state.data.currentTestIndex - 1;
    final lastQuestionIndexInPrevTest = state.data.tests[prevTestIndex].questions.length - 1;

    emit(state.copyWith(
      data: state.data.copyWith(
        currentTestIndex: state.data.currentTestIndex - 1,
        currentQuestionIndex: lastQuestionIndexInPrevTest,
      ),
    ));
  }

  FutureOr<void> _onPrevQuestion(_PrevQuestion event, Emitter<MentalHealthState> emit) {
    if (state.data.isFirstQuestion) return null;

    emit(state.copyWith(
      data: state.data.copyWith(
        currentQuestionIndex: state.data.currentQuestionIndex - 1,
      ),
    ));

    _onboardingBloc.add(
      OnboardingEvent.currentStepChanged(
        progress: state.data.progressPercentage,
        questionIndex: state.data.currentQuestionIndex,
      ),
    );
  }

  FutureOr<void> _onNextQuestion(_NextQuestion event, Emitter<MentalHealthState> emit) {
    if (state.data.isLastMentalHealthQuestion) {
      _onboardingBloc.add(
        OnboardingEvent.currentStepChanged(
          progress: 100,
          questionIndex: state.data.currentQuestionIndex,
        ),
      );

      return null;
    }

    if (state.data.isLastQuestionInTest) return null;

    emit(state.copyWith(
      data: state.data.copyWith(
        currentQuestionIndex: state.data.currentQuestionIndex + 1,
      ),
    ));

    _onboardingBloc.add(
      OnboardingEvent.currentStepChanged(
        progress: state.data.progressPercentage,
        questionIndex: state.data.currentQuestionIndex,
      ),
    );
  }

  FutureOr<void> _onNextPage(_NextPage event, Emitter<MentalHealthState> emit) {
    emit(state.copyWith(
      data: state.data.copyWith(
        currentPage: state.data.currentPage + 1,
      ),
    ));
  }

  FutureOr<void> _onPrevPage(_PrevPage event, Emitter<MentalHealthState> emit) {
    if (state.data.currentPage == 0) return null;

    emit(state.copyWith(
      data: state.data.copyWith(
        currentPage: state.data.currentPage - 1,
      ),
    ));
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

    emit(state.copyWith(
      data: state.data.copyWith(
        answers: newAnswers,
      ),
    ));
  }

  FutureOr<void> _onGetTestResults(_GetTestResults event, Emitter<MentalHealthState> emit) async {
    final currentTest = state.data.currentTest;

    if (currentTest == null) return;

    emit(state.copyWith(
      data: state.data.copyWith(
        isLoading: true,
      ),
    ));

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
      (e) => emit(state.copyWith(
        data: state.data.copyWith(isLoading: false, error: e),
      )),
      (r) {
        emit(state.copyWith(
          data: state.data.copyWith(
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
        ));
      },
    );
  }

  FutureOr<void> _onSetCompleted(event, Emitter<MentalHealthState> emit) {
    emit(state.copyWith(
      data: state.data.copyWith(isCompleted: event.value),
    ));
  }

  FutureOr<void> _onSetStartTime(_SetStartTime event, Emitter<MentalHealthState> emit) {
    emit(state.copyWith(data: state.data.copyWith(startTestTime: event.time)));
  }

  FutureOr<void> _onStartTestFromBeginning(_StartTestFromBeginning event, Emitter<MentalHealthState> emit) {
    emit(state.copyWith(
      data: state.data.copyWith(
        startTestTime: null,
        results: {},
        answers: [],
        currentQuestionIndex: 0,
        currentTestIndex: 0,
        currentPage: 0,
      ),
    ));

    _onboardingBloc.add(
      const OnboardingEvent.currentStepChanged(
        progress: 0,
        questionIndex: 0,
      ),
    );
  }

  FutureOr<void> _onResetData(_ResetData event, Emitter<MentalHealthState> emit) {
    emit(MentalHealthState.initial());
  }

  @override
  MentalHealthState? fromJson(Map<String, dynamic> json) => MentalHealthState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(MentalHealthState state) {
    return state.toJson();
  }
}
