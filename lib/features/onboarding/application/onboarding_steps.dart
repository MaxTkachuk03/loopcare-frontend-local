part of 'onboarding_bloc.dart';

enum OnboardingSteps {
  physicalFitness,
  medicalFitness,
  mentalFitness,
}

extension OnboardingStepsX on OnboardingSteps {
  List<PageRouteInfo> get stepRoutes {
    switch (this) {
      case OnboardingSteps.physicalFitness:
        return _getStepRoutes(PhysicalFitnessQuestions.values);
      case OnboardingSteps.medicalFitness:
        return _getStepRoutes(PhysicalFitnessQuestions.values); // TODO: change after adding enum for medicalFitness step
      case OnboardingSteps.mentalFitness:
        return _getStepRoutes(PhysicalFitnessQuestions.values); // TODO: change after adding enum for mentalFitness step
    }
  }

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

  List<PageRouteInfo> _getStepRoutes(List<PhysicalFitnessQuestions> values) {
    return values.map((e) => e.route).toList();
  }
}
