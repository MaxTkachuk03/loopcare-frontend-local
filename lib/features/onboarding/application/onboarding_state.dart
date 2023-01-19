part of 'onboarding_bloc.dart';

@freezed
class OnboardingState with _$OnboardingState {
  factory OnboardingState.initial() => OnboardingState(
        currentStep: OnboardingSteps.values[0],
      );

  const factory OnboardingState({
    required OnboardingSteps currentStep,
    @Default(0) int currentStepProgress,
    @Default(0) int currentQuestionIndex,
    @Default(false) bool isCompleted,
    @Default(false) bool isStarted,
  }) = _OnboardingState;

  const OnboardingState._();

  factory OnboardingState.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStateFromJson(json);
}
