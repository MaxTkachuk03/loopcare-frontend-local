import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/injection.dart';

@Deprecated('Not used since 1.2.0')
class IntroGuard extends AutoRouteGuard {
  final AuthenticationBloc authenticationBloc;
  final SharedStorageService storage = getIt<SharedStorageService>();
  final GeneralOnboardingBloc onboardingBloc;
  final ConsentConfirmationBloc consentConfirmationBloc;
  final LegalStatementBloc legalStatementBloc;
  final MentalQuestionsBloc mentalHealthBloc;
  final AuthTokenManager authTokenManager;

  IntroGuard(
    this.authenticationBloc,
    this.onboardingBloc,
    this.consentConfirmationBloc,
    this.legalStatementBloc,
    this.mentalHealthBloc,
    this.authTokenManager,
  );

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    String route;

    authenticationBloc.add(const AuthenticationEvent.startTrackUser());

    if (storage.account != null) {
      final accessToken = await authTokenManager.getAccessToken() ?? '';
      final refreshToken = await authTokenManager.getRefreshToken() ?? '';

      if (accessToken.isEmpty || refreshToken.isEmpty) {
        route = AppRoutes.login;
      } else if ((storage.account?.hasActiveSubscription ?? false) || !kIsProd) {
        route = AppRoutes.home;
      } else {
        route = AppRoutes.subscription;
      }

      MixpanelEventService.instance.trackVisit(
        "${AppMixpanelEvents.appRote}:  $route",
        userId: storage.account?.id ?? -1,
      );
      router.replaceNamed(route);

      return;
    }

    final List<PageRouteInfo> needRoutes = [];

    final authState = authenticationBloc.state;
    final onboardingState = onboardingBloc.state;

    final legalStatementWasPassed = legalStatementBloc.state.pageWasPassed;

    final onboardingNotStarted = authState.data.name.isEmpty && !onboardingState.isCompleted && storage.account == null;
    final onboardingFinished = !authState.data.accountId.isNegative && !onboardingState.isCompleted;

    if (onboardingNotStarted || onboardingFinished) {
      router.replace(const IntroRoute());

      return;
    }

    if (authState.data.name.isNotEmpty) {
      needRoutes.addAll([
        const IntroRoute(),
        const JoinUsRoute(),
        const NameRoute(),
        const EmailAddressRoute(),
      ]);
    }

    if (authState.data.email.isNotEmpty) {
      needRoutes.add(const SuccessVerifiedEmailRoute());
    }

    if (onboardingState.isStarted) {
      needRoutes.add(const OnboardingQuestionsRoute());
      onboardingBloc.add(const GeneralOnboardingEvent.resumeTimer());
    }

    if (onboardingState.isCompleted && !legalStatementWasPassed) {
      needRoutes.add(const LegalStatementRoute());
    }

    if (legalStatementWasPassed) {
      needRoutes.addAll([
        const SignUpWelcomeRoute(),
        const PasswordRoute(),
      ]);
    }

    if (authState.data.emailWasSend) {
      needRoutes.add(const WaitingForConfirmationRoute());
    }

    if (needRoutes.isNotEmpty) {
      router.pushAll(needRoutes);

      return;
    }

    resolver.next(false);
  }
}
