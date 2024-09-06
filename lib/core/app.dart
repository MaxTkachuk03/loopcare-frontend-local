import 'package:auto_route/auto_route.dart';
import 'package:crowdin_sdk/crowdin_sdk.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/localization/app_localizations.dart';
import 'package:loopcare_frontend/core/application/localization/crowdin_localizations.dart';
import 'package:loopcare_frontend/core/application/connectivity_bloc/connectivity_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/uxcam/uxcam_navigation_observer.dart';
import 'package:loopcare_frontend/core/infrastructure/route_observers/route_observer_utils.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_bloc_provider.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/services/facebook_events_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_navigator_observer.dart';
import 'package:loopcare_frontend/core/infrastructure/services/local_localization_service/local_localization_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/injection.dart';

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
    _appRouter = AppRouter();
    kNavigatorKey = _appRouter.navigatorKey;
    FacebookEventsService();
  }

  Future<void> _initializeCrowdin() async {
    await loadLocalLocalizations();
    await Crowdin.loadTranslations(currentLocale);

    log.i('Current locale: ${currentLocale.languageCode}', error: 'CROWDIN');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeCrowdin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done ||
            (getIt<LocalLocalizationService>().translations?.isNotEmpty ?? false)) {
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
                ],
              ),
              routeInformationParser: _appRouter.defaultRouteParser(),
              localizationsDelegates: CrowdinLocalization.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: currentLocale,
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CustomText(
                  LocalizedTexts.errorLoadTranslations.tr(),
                ),
              ),
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
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
