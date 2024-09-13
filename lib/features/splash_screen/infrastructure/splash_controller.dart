import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bloc.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/permissions_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/apps_flyer_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/stored_account_service/stored_account_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/transparency/applictation/device_info_service.dart';
import 'package:loopcare_frontend/injection.dart';

class SplashController {
  final AuthenticationBloc authenticationBloc;
  final AppUpdateBloc appUpdateBloc;
  final GeneralOnboardingBloc onboardingBloc;
  final LegalStatementBloc legalStatementBloc;
  final RiverBloc riverBloc;
  final NavigationBarBloc navigationBarBloc;

  const SplashController({
    required this.authenticationBloc,
    required this.appUpdateBloc,
    required this.onboardingBloc,
    required this.legalStatementBloc,
    required this.riverBloc,
    required this.navigationBarBloc,
  });

  bool get isAuthorized => StoredAccountService.getAccount() != null;

  bool get needUpdatePrivacyPolicy =>
      (authenticationBloc.state.data.account?.privacyPolicyVersion ?? 1) <
      appUpdateBloc.state.data.privacyPolicyVersion;

  bool get needUpdateTermsAndConditions =>
      (authenticationBloc.state.data.account?.termsAndConditionsVersion ?? 1) <
      appUpdateBloc.state.data.termsAndConditionsVersion;

  void initApp() {
    _getVersion();
    _connectSockets();
    navigationBarBloc.add(const NavigationBarEvent.init());
  }

  void requestPermissions() async {
    await getIt<DeviceInfoService>().onRequestTrackingAuthorization();
    await PermissionsService.instance.requestNotificationPermissions();

    if (kIsProd && !kIsAnalyticTestingEnv) await AppsFlyerService.start();
  }

  Future<List<PageRouteInfo>> getRoute() async {
    authenticationBloc.add(const AuthenticationEvent.startTrackUser());

    // TODO: remove at version 1.6.0 or higher
    authenticationBloc.add(const AuthenticationEvent.sendApsFlyerData());

    final account = StoredAccountService.getAccount();

    final authorisedRoute = await _getAuthorisedRoute(account?.hasActiveSubscription ?? false);
    final routes = [authorisedRoute];

    return routes;
  }

  void _getVersion() => appUpdateBloc.add(const AppUpdateEvent.getVersion());

  void _connectSockets() => authenticationBloc.add(const AuthenticationEvent.connectSockets());

  void updatePolicy() => authenticationBloc.add(
        AuthenticationEvent.updatePolicy(
          privacyPolicyVersion: appUpdateBloc.state.data.privacyPolicyVersion,
          termsAndConditionsVersion: appUpdateBloc.state.data.termsAndConditionsVersion,
        ),
      );

  void getAccount() => authenticationBloc.add(const AuthenticationEvent.getAccount());

  Future<PageRouteInfo> _getAuthorisedRoute(bool hasActiveSubscription) async {
    final authTokenManager = getIt<AuthTokenManager>();
    final storage = getIt<SharedStorageService>();

    final accessToken = await authTokenManager.getAccessToken() ?? '';
    final refreshToken = await authTokenManager.getRefreshToken() ?? '';

    if (accessToken.isEmpty || refreshToken.isEmpty) {
      return const LoginRoute();
    } else if (!hasActiveSubscription && kIsProd) {
      return const SubscriptionRoute();
    } else if (!riverBloc.state.data.isBeginningStarted &&
        !riverBloc.state.data.isBeginningComplete &&
        !storage.isRiverOverviewVisited) {
      return const RiverOverviewRoute();
    } else {
      return const HomeRoute();
    }
  }

  void setUpBottomNavigationBar() {
    if (!riverBloc.state.data.isBeginningComplete ||
        !navigationBarBloc.state.data.isProfileOpen ||
        !navigationBarBloc.state.data.isPracticeOpen) {
      navigationBarBloc.add(
        NavigationBarEvent.setBeginningUncompleted(
          isPracticeOpened: riverBloc.state.data.isPracticeCompleted,
          isProfileOpened: riverBloc.state.data.isProfileCompleted,
        ),
      );
    }
  }

  List<PageRouteInfo> getOnboardingRoute() {
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
        const NameRoute(),
        const EmailAddressRoute(),
      ]);
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

  void getRiverModules() => riverBloc.add(const RiverEvent.getModules());
}
