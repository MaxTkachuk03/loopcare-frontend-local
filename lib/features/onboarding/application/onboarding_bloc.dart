import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';

part 'onboarding_bloc.freezed.dart';

part 'onboarding_bloc.g.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

part 'onboarding_steps.dart';

@singleton
class OnboardingBloc extends HydratedBloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState.initial()) {
    on<Started>(_onStarted);
    on<NextStep>(_onNextStep);
    on<PreviousStep>(_onPreviousStep);
    on<CurrentStepChanged>(_onCurrentStepChanged);
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
      emit(state.copyWith(currentStep: state.currentStep.getNextStep()));
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
      ));
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
