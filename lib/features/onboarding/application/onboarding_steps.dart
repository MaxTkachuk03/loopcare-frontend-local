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
        return PhysicalFitnessQuestions.values.map((e) => e.route).toList();
      case OnboardingSteps.medicalFitness:
        return medicalFitnessQuestions.map((e) => getQuestionRoute(e)).toList();
      case OnboardingSteps.mentalFitness:
        return PhysicalFitnessQuestions.values
            .map((e) => e.route)
            .toList(); // TODO change to mental health routes
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
}
