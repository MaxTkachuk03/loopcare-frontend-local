import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';

part 'onboarding_bloc.freezed.dart';

part 'onboarding_bloc.g.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

part 'onboarding_steps.dart';

@singleton
class OnboardingBloc extends HydratedBloc<OnboardingEvent, OnboardingState> {
  final AuthenticationCubit _authenticationCubit;

  late final StreamSubscription _authBlocStreamSubscription;

  OnboardingBloc(this._authenticationCubit) : super(OnboardingState.initial()) {
    on<Started>(_onStarted);
    on<NextStep>(_onNextStep);
    on<PreviousStep>(_onPreviousStep);
    on<CurrentStepChanged>(_onCurrentStepChanged);
    on<ResetData>(_onResetData);

    _authBlocStreamSubscription =
        _authenticationCubit.stream.distinct().listen((s) {
      s.mapOrNull(
        authenticated: (_) {
          add(const OnboardingEvent.resetData());
        },
      );
    });
  }

  @override
  Future<void> close() async {
    _authBlocStreamSubscription.cancel();

    return super.close();
  }

  FutureOr<void> _onResetData(ResetData event, Emitter<OnboardingState> emit) {
    emit(OnboardingState.initial());
  }

  FutureOr<void> _onStarted(Started event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(isStarted: true));
  }

  FutureOr<void> _onNextStep(NextStep event, Emitter<OnboardingState> emit) {
    final isLastStep =
        state.currentStep.index == OnboardingSteps.values.length - 1;
    if (isLastStep) {
      emit(state.copyWith(isCompleted: true));
    } else {
      emit(state.copyWith(
        currentStep: state.currentStep.getNextStep(),
        currentQuestionIndex: 0,
        currentStepProgress: 0,
      ));
    }
  }

  FutureOr<void> _onPreviousStep(
    PreviousStep event,
    Emitter<OnboardingState> emit,
  ) {
    final isFirstStep = state.currentStep.index == 0;
    if (!isFirstStep) {
      emit(state.copyWith(
          currentStep: state.currentStep.getPreviousStep(),
          currentStepProgress: 100,
          currentQuestionIndex:
              state.currentStep.getPreviousStep().stepRoutes.length - 1));
    }
  }

  FutureOr<void> _onCurrentStepChanged(
    CurrentStepChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(
      currentStepProgress: event.progress,
      currentQuestionIndex: event.questionIndex,
    ));
  }

  @override
  OnboardingState? fromJson(Map<String, dynamic> json) =>
      OnboardingState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(OnboardingState state) {
    return state.toJson();
  }
}
