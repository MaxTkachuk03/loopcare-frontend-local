part of 'onboarding_bloc.dart';

@freezed
class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.started() = Started;

  const factory OnboardingEvent.nextStep() = NextStep;

  const factory OnboardingEvent.previousStep() = PreviousStep;

  const factory OnboardingEvent.resetData() = ResetData;

  const factory OnboardingEvent.currentStepChanged({
    required int progress,
    required int questionIndex,
  }) = CurrentStepChanged;
}
