import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/uxcam/uxcam_navigation_observer.dart';
import 'package:loopcare_frontend/core/infrastructure/route_observers/route_observer_utils.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_bloc_provider.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/services/facebook_events_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_navigator_observer.dart';
import 'package:loopcare_frontend/core/infrastructure/services/network_service/network_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:provider/provider.dart';

final autoRouteObserver = AutoRouteObserver();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<NetworkStatus>(
          initialData: NetworkStatus.online,
          create: (context) => getIt<NetworkStatusService>().networkStatusController.stream,
        ),
        MultiBlocProvider(
          providers: AppBlocProvider.providers,
          child: const _App(),
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
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
    kNavigatorKey = _appRouter.navigatorKey;
    FacebookEventsService();

    FacebookEventsService.logEvent(
      eventName: AnalyticsEvents.onboardingNewUserCreated,
      parameters: {
        AnalyticsParameters.confirmed: 'false',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Loop care',
      theme: appThemeData,
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [
          RouteObserverUtils(),
          UxcamNavigationObserver(),
          FirebaseNavigatorObserver(
            analytics: _analytics,
          ),
        ],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }

  @override
  void dispose() {
    getIt<NetworkStatusService>().dispose();
    super.dispose();
  }
}
