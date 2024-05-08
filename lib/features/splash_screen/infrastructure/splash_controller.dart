import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bloc.dart';
import 'package:loopcare_frontend/core/application/apps_flyer/apps_flyer_service.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/permissions_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/transparency/applictation/device_info_service.dart';
import 'package:loopcare_frontend/injection.dart';

class SplashController {
  final AuthenticationBloc authenticationBloc;
  final AppUpdateBloc appUpdateBloc;
  final GeneralOnboardingBloc onboardingBloc;
  final LegalStatementBloc legalStatementBloc;

  const SplashController({
    required this.authenticationBloc,
    required this.appUpdateBloc,
    required this.onboardingBloc,
    required this.legalStatementBloc,
  });

  void initApp() {
    _getVersion();
    _connectSockets();
  }

  void requestPermissions() async {
    await getIt<DeviceInfoService>().onRequestTrackingAuthorization();
    await PermissionsService.instance.requestNotificationPermissions();

    if (kIsProd) await AppsFlyerService.start();
  }

  Future<List<PageRouteInfo>> getRoute() async {
    SharedStorageService storage = getIt<SharedStorageService>();

    authenticationBloc.add(const AuthenticationEvent.startTrackUser());

    List<PageRouteInfo> routes = [];

    if (storage.account != null) {
      final authorisedRoute = await _getAuthorisedRoute(storage.account?.hasActiveSubscription ?? false);
      routes = [authorisedRoute];
    } else {
      routes = _getOnboardingRoute();
    }

    MixpanelEventService.instance.trackVisit(
      "${AppMixpanelEvents.appRote}: ${routes.last.routeName}",
      userId: storage.account?.id ?? -1,
    );

    return routes;
  }

  void _getVersion() => appUpdateBloc.add(const AppUpdateEvent.getVersion());


  void _connectSockets() => authenticationBloc.add(const AuthenticationEvent.connectSockets());

  Future<PageRouteInfo> _getAuthorisedRoute(bool hasActiveSubscription) async {
    AuthTokenManager authTokenManager = getIt<AuthTokenManager>();

    final accessToken = await authTokenManager.getAccessToken() ?? '';
    final refreshToken = await authTokenManager.getRefreshToken() ?? '';

    if (accessToken.isEmpty || refreshToken.isEmpty) {
      return const LoginRoute();
    } else if (hasActiveSubscription || !kIsProd) {
      return const HomeRoute();
    } else {
      return const SubscriptionRoute();
    }
  }

  List<PageRouteInfo> _getOnboardingRoute() {
    final authState = authenticationBloc.state;
    final onboardingState = onboardingBloc.state;

    final legalStatementWasPassed = legalStatementBloc.state.pageWasPassed;

    final onboardingNotStarted = authState.data.name.isEmpty && !onboardingState.isCompleted;
    final onboardingFinished = !authState.data.accountId.isNegative && !onboardingState.isCompleted;

    if (onboardingNotStarted || onboardingFinished) {
      return [const IntroRoute()];
    }

    final List<PageRouteInfo> needRoutes = [const IntroRoute()];

    if (authState.data.name.isNotEmpty) {
      needRoutes.addAll([
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

    return needRoutes;
  }
}
