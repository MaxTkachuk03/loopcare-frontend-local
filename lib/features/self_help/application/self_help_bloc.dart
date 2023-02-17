import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/bmi_validator.dart';

part 'self_help_bloc.freezed.dart';

part 'self_help_bloc.g.dart';

part 'self_help_event.dart';

part 'self_help_state.dart';

part 'self_help_questions.dart';

@singleton
class SelfHelpBloc extends HydratedBloc<SelfHelpEvent, SelfHelpState> {
  final OnboardingBloc onboardingBloc;
  final AuthenticationCubit _authenticationCubit;

  late final StreamSubscription _authBlocStreamSubscription;

  SelfHelpBloc(this.onboardingBloc, this._authenticationCubit)
      : super(SelfHelpState.initial()) {
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<PreferGenderTypeChanged>(_onPreferGenderTypeChanged);

    on<ResetData>(_onResetData);

    _authBlocStreamSubscription =
        _authenticationCubit.stream.distinct().listen((s) {
      s.mapOrNull(
        authenticated: (_) {
          add(const SelfHelpEvent.resetData());
        },
      );
    });
  }

  @override
  Future<void> close() async {
    _authBlocStreamSubscription.cancel();

    return super.close();
  }

  FutureOr<void> _onResetData(
    ResetData event,
    Emitter<SelfHelpState> emit,
  ) {
    emit(SelfHelpState.initial());
  }

  FutureOr<void> _onNextQuestion(
    NextQuestion event,
    Emitter<SelfHelpState> emit,
  ) {
    final currentQuestion = state.currentQuestion;
    final nextQuestion = currentQuestion.getNextQuestion();

    final isCompleted = nextQuestion == SelfHelpQuestions.result;

    if (isCompleted) {
      final bool isValidBmi =
          BmiValidator.isUserAllowToProceed(state.age!, state.bmi);

      emit(state.copyWith(
        isCompletedSuccessfully: isValidBmi,
        currentQuestion: isValidBmi ? nextQuestion : currentQuestion,
      ));

      if (isValidBmi) {
        onboardingBloc.add(
          OnboardingEvent.currentStepChanged(
            progress: nextQuestion.percentage.toInt(),
            questionIndex: nextQuestion.index,
          ),
        );
      }
    } else {
      emit(state.copyWith(currentQuestion: nextQuestion));

      onboardingBloc.add(
        OnboardingEvent.currentStepChanged(
          progress: nextQuestion.percentage.toInt(),
          questionIndex: nextQuestion.index,
        ),
      );
    }
  }

  FutureOr<void> _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<SelfHelpState> emit,
  ) {
    final isFirstQuestion = state.currentQuestion.index == 0;
    final previousQuestion = state.currentQuestion.getPreviousQuestion();

    if (!isFirstQuestion) {
      emit(state.copyWith(
        currentQuestion: previousQuestion,
      ));
    }

    onboardingBloc.add(OnboardingEvent.currentStepChanged(
      progress: previousQuestion.percentage.toInt(),
      questionIndex: previousQuestion.index,
    ));
  }

  FutureOr<void> _onPreferGenderTypeChanged(
    PreferGenderTypeChanged event,
    Emitter<SelfHelpState> emit,
  ) {
    emit(state.copyWith(
      heightInCm: event.height,
      heightMeasurementSystemType: event.measurementSystemType,
    ));
  }

  @override
  SelfHelpState? fromJson(Map<String, dynamic> json) =>
      SelfHelpState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SelfHelpState state) {
    return state.toJson();
  }
}
