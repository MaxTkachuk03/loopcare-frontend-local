import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/socket_service/socket_service.dart';
import 'package:loopcare_frontend/core/application/socket_service_chat/chat_socket_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_bloc_provider.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_navigator_observer.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/routes/gender_prefs_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/intro_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/proxy_guard.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:provider/provider.dart';

import 'infrastructure/services/network_service/network_service.dart';
import 'presentation/alerting/show_app_snackbar.dart';

final autoRouteObserver = AutoRouteObserver();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<NetworkStatus>(
            initialData: NetworkStatus.online,
            create: (context) => getIt<NetworkStatusService>().networkStatusController.stream),
        MultiBlocProvider(
          providers: AppBlocProvider.providers,
          child: Builder(
            builder: (context) {
              final networkStatus = Provider.of<NetworkStatus>(context);
              if (networkStatus == NetworkStatus.offline) {
                showConnectionErrorMessage();
              }
              return const _App();
            },
          ),
        ),
      ],
    );
  }
}

class _App extends StatefulWidget {
  const _App();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<_App> {
  late final AppRouter _appRouter;
  String _authStatus = 'Unknown';
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final SocketService _socketService = SocketService.instance;
  final ChatSocketService _chatSocketService = ChatSocketService.instance;
  static final FirebaseAnalyticsObserver _analyticsObserver = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void initState() {
    super.initState();
    final authBloc = context.read<AuthenticationCubit>();
    final onboardingBloc = context.read<OnboardingBloc>();
    final legalStatementBloc = context.read<LegalStatementBloc>();
    final consentConfirmationBloc = context.read<ConsentConfirmationBloc>();
    final mentalHealthBloc = context.read<MentalHealthBloc>();
    final authTokenManager = GetIt.instance<AuthTokenManager>();

    _socketService.startListen();
    _chatSocketService.startListen();

    if (Platform.isIOS) WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());

    _appRouter = AppRouter(
      proxyGuard: ProxyGuard(authBloc, authTokenManager),
      introGuard: IntroGuard(
        authBloc,
        onboardingBloc,
        consentConfirmationBloc,
        legalStatementBloc,
        mentalHealthBloc,
        authTokenManager,
      ),
      genderPrefsGuard: GenderPrefsGuard(authBloc),
    );
  }

  @override
  void dispose() {
    getIt<NetworkStatusService>().dispose();
    super.dispose();
  }

  Future<void> initPlugin() async {
    try {
      final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
      _authStatus = '$status';
      // If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined) {
        final TrackingStatus status = await AppTrackingTransparency.requestTrackingAuthorization();
        _authStatus = '$status';
      }
    } on PlatformException {
      _authStatus = 'PlatformException was thrown';
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    debugPrint("devcpp UUID: $uuid");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Loop care',
      theme: appThemeData,
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [
          FirebaseNavigatorObserver(analytics: analytics),
        ],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
