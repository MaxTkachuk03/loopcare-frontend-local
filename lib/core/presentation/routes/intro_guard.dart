import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/presentation/registration_restoring.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

class IntroGuard extends AutoRouteGuard {
  AuthenticationCubit authenticationCubit;
  OnboardingBloc onboardingBloc;
  ConsentConfirmationBloc consentConfirmationBloc;
  LegalStatementBloc legalStatementBloc;

  IntroGuard(
    this.authenticationCubit,
    this.onboardingBloc,
    this.consentConfirmationBloc,
    this.legalStatementBloc,
  );

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    if (authenticationCubit.state.isAuthenticated) {
      final route = authenticationCubit.state.isPreferencesComplete
          ? AppRoutes.home
          : AppRoutes.preferencesOverview;

      router.replaceNamed(route);

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

      List<PageRouteInfo<dynamic>> needRoutes = [];
      needRoutes.add(const PreferencesOverviewRoute());
      needRoutes.addAll(routes.take(routeIndex + 1).toList());
      router.pushAll(
        needRoutes,
      );

      return;
    }

    final consentConfirmationWasPassed =
        consentConfirmationBloc.state.pageWasPassed;

    if (onboardingState.isCompleted && !consentConfirmationWasPassed) {
      router.replaceNamed(AppRoutes.consentConfirmation);

      return;
    }

    final legalStatementWasPassed = legalStatementBloc.state.pageWasPassed;

    if (onboardingState.isCompleted && !legalStatementWasPassed) {
      router.replaceNamed(AppRoutes.legalStatement);

      return;
    }

    final isGuestMode = authenticationCubit.state.maybeWhen(
      orElse: () => true,
      authenticated: (_) => false,
    );

    if (onboardingState.isStarted &&
        onboardingState.isCompleted &&
        isGuestMode) {
      registrationRestoring(router, authenticationCubit);

      return;
    }

    resolver.next(true);
  }
}
