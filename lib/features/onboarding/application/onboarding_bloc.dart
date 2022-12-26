import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_bloc.freezed.dart';

part 'onboarding_bloc.g.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

part 'onboarding_steps.dart';

@singleton
class OnboardingBloc extends HydratedBloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState.initial()) {
    on<NextStep>(_onNextStep);
    on<PreviousStep>(_onPreviousStep);
    on<CurrentStepProgressChanged>(_onCurrentStepProgressChanged);
  }

  FutureOr<void> _onNextStep(NextStep event, Emitter<OnboardingState> emit) {
    final isLastStep = state.currentStep.index == OnboardingSteps.values.length - 1;
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

  FutureOr<void> _onCurrentStepProgressChanged(
    CurrentStepProgressChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(currentStepProgress: event.progress));
  }

  @override
  OnboardingState? fromJson(Map<String, dynamic> json) =>
      OnboardingState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(OnboardingState state) {
    return state.toJson();
  }
}
