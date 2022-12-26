part of 'onboarding_bloc.dart';

enum OnboardingSteps {
  physicalFitness,
  medicalFitness,
  mentalFitness,
}

extension OnboardingStepsX on OnboardingSteps {
  OnboardingSteps getNextStep() {
    if (index == OnboardingSteps.values.length - 1) {
      return this;
    }

    return OnboardingSteps.values[index + 1];
  }

  OnboardingSteps getPreviousStep() {
    if (index == 0) {
      return this;
    }

    return OnboardingSteps.values[index - 1];
  }
}
