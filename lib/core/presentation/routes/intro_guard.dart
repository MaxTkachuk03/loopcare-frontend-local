import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

class IntroGuard extends AutoRouteGuard {
  AuthenticationCubit authenticationCubit;
  OnboardingBloc onboardingBloc;

  IntroGuard(this.authenticationCubit, this.onboardingBloc);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isAuthenticated = authenticationCubit.state.maybeWhen(
      orElse: () => false,
      authenticated: (_) => true,
    );
    if (isAuthenticated) {
      router.replaceNamed(AppRoutes.home);

      return;
    }

    final onboardingState = onboardingBloc.state;

    if (onboardingState.isStarted && !onboardingState.isCompleted) {
      final currentStepIndex = onboardingState.currentStep.index;
      final routes = OnboardingSteps.values
          .getRange(0, currentStepIndex + 1)
          .map((e) => e.stepRoutes)
          .expand((element) => element)
          .toList();
      final currentRoute = onboardingState
          .currentStep.stepRoutes[onboardingState.currentQuestionIndex];
      final routeIndex = routes.indexOf(currentRoute);

      router.replaceAll(
        routes.take(routeIndex + 1).toList(),
      );

      return;
    }

    final isGuestMode = authenticationCubit.state.maybeWhen(
      orElse: () => true,
      authenticated: (_) => false,
    );

    if (onboardingState.isStarted &&
        onboardingState.isCompleted &&
        isGuestMode) {
      router.replaceNamed(AppRoutes.signUpWelcome);

      return;
    }

    resolver.next(true);

  }
}
