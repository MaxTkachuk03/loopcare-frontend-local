import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/presentation/registration_restoring.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

class IntroGuard extends AutoRouteGuard {
  AuthenticationCubit authenticationCubit;
  OnboardingBloc onboardingBloc;
  ConsentConfirmationBloc consentConfirmationBloc;
  LegalStatementBloc legalStatementBloc;
  MentalHealthBloc mentalHealthBloc;
  AuthTokenManager authTokenManager;

  IntroGuard(
    this.authenticationCubit,
    this.onboardingBloc,
    this.consentConfirmationBloc,
    this.legalStatementBloc,
    this.mentalHealthBloc,
    this.authTokenManager,
  );

  List<PageRouteInfo> _getMentalHealthRoutes() {
    final tests = mentalHealthBloc.state.data.tests;
    if (tests.isEmpty) return [const MentalHealthIntroRoute()];

    final mentalHealthRoutes = tests
        .map((e) {
          final questionRoutes = e.questions.map((e) => const MentalHealthQuestionRoute()).toList();

          return [
            ...questionRoutes,
            MentalCheckResultRoute(calculationResultsNotNeeded: true) as PageRouteInfo<void>
          ];
        })
        .expand((element) => element)
        .toList();

    return [
      const MentalHealthIntroRoute(),
      ...mentalHealthRoutes,
      MentalCheckResultRoute(calculationResultsNotNeeded: true)
    ];
  }

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    String route;
    if (authenticationCubit.state.isAuthenticated) {
      final accessTokenIsUpdated = await authTokenManager.updateAccessToken();
      final refreshTokenIsUpdated = await authTokenManager.updateRefreshToken();

      if (!(accessTokenIsUpdated && refreshTokenIsUpdated)) {
        route = AppRoutes.login;
      } else if (authenticationCubit.state.hasActiveSubscription) {
        route = AppRoutes.home ;
      } else {
        route = AppRoutes.subscription;
      }
      MixpanelEventService.instance.trackVisit(
        "${AppMixpanelEvents.appRote}:  $route",
        userId: authenticationCubit.state.id,
      );
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

      final isMentalFitness = onboardingState.currentStep == OnboardingSteps.mentalFitness;

      final routeIndex = isMentalFitness
          ? routes.length + mentalHealthBloc.state.data.currentPage
          : routes.indexOf(onboardingState.currentStep.stepRoutes[onboardingState.currentQuestionIndex]);

      final mentalHealthRoutes = isMentalFitness ? _getMentalHealthRoutes() : <PageRouteInfo>[];

      routes.addAll(mentalHealthRoutes);

      List<PageRouteInfo<dynamic>> needRoutes = [];

      needRoutes.add(const IntroRoute());
      needRoutes.add(const JoinUsRoute());

      needRoutes.addAll(routes.take(routeIndex + 1).toList());
      router.pushAll(
        needRoutes,
      );

      return;
    }

    final consentConfirmationWasPassed = consentConfirmationBloc.state.pageWasPassed;

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

    if (onboardingState.isStarted && onboardingState.isCompleted && isGuestMode) {
      registrationRestoring(router, authenticationCubit);

      return;
    }

    resolver.next(true);
  }
}
