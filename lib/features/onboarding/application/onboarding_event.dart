part of 'onboarding_bloc.dart';

@freezed
class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.nextStep() = NextStep;

  const factory OnboardingEvent.previousStep() = PreviousStep;

  const factory OnboardingEvent.currentStepProgressChanged(int progress) =
      CurrentStepProgressChanged;
}
