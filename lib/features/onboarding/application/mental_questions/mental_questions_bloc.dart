import 'dart:async';
import 'package:collection/collection.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_attributes.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/mental_health_test_answers.dart';
import 'package:loopcare_frontend/features/onboarding/application/dto/answers_body.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/mental_health_service.dart';
import 'package:loopcare_frontend/features/onboarding/domain/interpretation_type.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_answer.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_test.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_test_type.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/test_result.dart';

part 'mental_questions_bloc.freezed.dart';
part 'mental_questions_bloc.g.dart';
part 'mental_questions_event.dart';
part 'mental_questions_state.dart';

@singleton
class MentalQuestionsBloc extends HydratedBloc<MentalQuestionsEvent, MentalQuestionsState> {
  final MentalHealthService _mentalHealthService;
  final usageAnalytics = UsageAnalytics();

  MentalQuestionsBloc(this._mentalHealthService) : super(MentalQuestionsState.initial()) {
    on<_SetAnswer>(_onSetAnswer);
    on<_GetTestResults>(_onGetTestResults);
    on<_StartTestFromBeginning>(_onStartTestFromBeginning);
    on<_ResetData>(_onResetData);
  }

  FutureOr<void> _onSetAnswer(
    _SetAnswer event,
    Emitter<MentalQuestionsState> emit,
  ) {
    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.onboardingTestAnswer,
      attributes: {
        UsageAnalyticsAttributes.testName: event.testName,
        UsageAnalyticsAttributes.question: event.question,
        UsageAnalyticsAttributes.selectedOption: event.selectedOption
      },
    );

    List<MentalHealthAnswer> newAnswers = [...state.answers];
    final existingQuestionIndex =
        newAnswers.indexWhere((element) => element.questionId == event.answer.questionId);

    if (existingQuestionIndex.isNegative) {
      newAnswers = [...state.answers, event.answer];
    } else {
      newAnswers[existingQuestionIndex] = event.answer;
    }

    emit(
      state.copyWith(
        answers: newAnswers,
      ),
    );
  }

  FutureOr<void> _onGetTestResults(
    _GetTestResults event,
    Emitter<MentalQuestionsState> emit,
  ) async {
    final currentTest = event.test;

    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final answers = event.isCompleted
        ? state.answers
        : currentTest.questions
            .map((q) => state.answers.firstWhereOrNull((a) => a.questionId == q.id))
            .whereType<MentalHealthAnswer>()
            .toList();

    final response = await _mentalHealthService.getTestResults(AnswersBody(answers: answers));

    response.fold(
      (e) => emit(state.copyWith(isLoading: false, error: e)),
      (r) => emit(
        state.copyWith(
          results: {
            ...state.results,
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
  }

  FutureOr<void> _onStartTestFromBeginning(
    _StartTestFromBeginning event,
    Emitter<MentalQuestionsState> emit,
  ) {
    emit(
      state.copyWith(
        startTestTime: null,
        results: {},
        answers: [],
        isCompleted: false,
      ),
    );
  }

  FutureOr<void> _onResetData(
    _ResetData event,
    Emitter<MentalQuestionsState> emit,
  ) {
    emit(MentalQuestionsState.initial());
  }

  @override
  MentalQuestionsState? fromJson(Map<String, dynamic> json) => MentalQuestionsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(MentalQuestionsState state) {
    return state.toJson();
  }
}
