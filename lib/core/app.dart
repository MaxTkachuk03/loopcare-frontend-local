import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/connectivity_bloc/connectivity_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/uxcam/uxcam_navigation_observer.dart';
import 'package:loopcare_frontend/core/infrastructure/route_observers/route_observer_utils.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_bloc_provider.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/services/facebook_events_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_navigator_observer.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:loopcare_frontend/localization/src/app_localizations.dart';

final autoRouteObserver = AutoRouteObserver();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocProvider.providers,
      child: const _App(),
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

  Locale get currentLocale => Locale(getIt<AppConfig>().language);

  @override
  void initState() {
    super.initState();
    // TODO https://loopcare.atlassian.net/browse/LOOPCARE-3167 event should be added here
    _appRouter = AppRouter();
    kNavigatorKey = _appRouter.navigatorKey;
    FacebookEventsService();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) => state.whenOrNull(
        statusChanged: _connectivityListener,
      ),
      child: MaterialApp.router(
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
            NavigatorObserver(),
          ],
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: currentLocale,
      ),
    );
  }

  void _connectivityListener(ConnectivityStatus status) {
    if (status.isOffline) {
      kNavigatorKey.currentContext?.showFlashBar(
        text: LocalizedTexts.connectionLost.tr(),
      );
    }
  }
}
