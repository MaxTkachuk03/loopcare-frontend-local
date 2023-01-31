import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

void handleOnboardingRestore(BuildContext context) {
  final onboardingState = context.read<OnboardingBloc>().state;

  if (onboardingState.isCompleted || !onboardingState.isStarted) return;

  final currentStepIndex = onboardingState.currentStep.index;
  final routes = OnboardingSteps.values
      .getRange(0, currentStepIndex + 1)
      .map((e) => e.stepRoutes)
      .expand((element) => element)
      .toList();
  final currentRoute = onboardingState
      .currentStep.stepRoutes[onboardingState.currentQuestionIndex];
  final routeIndex = routes.indexOf(currentRoute);

  context.router.replaceAll(
    routes.take(routeIndex + 1).toList(),
  );
}
