import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bloc.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/infrastructure/route_observers/route_observer_utils.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_bloc_provider.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_navigator_observer.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/routes/gender_prefs_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/intro_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/proxy_guard.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/mental_questions/mental_questions_bloc.dart';
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
          create: (context) => getIt<NetworkStatusService>().networkStatusController.stream,
        ),
        MultiBlocProvider(
          providers: AppBlocProvider.providers,
          child: Builder(
            builder: (context) {
              final networkStatus = Provider.of<NetworkStatus>(context);
              if (networkStatus == NetworkStatus.offline) {
                context.showError(
                  content: CustomText(
                    LocalizedTexts.connectionLost.tr(),
                  ),
                );
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
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static final FirebaseAnalyticsObserver _analyticsObserver = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void initState() {
    super.initState();
    final authBloc = context.read<AuthenticationBloc>();
    final onboardingBloc = context.read<GeneralOnboardingBloc>();
    final legalStatementBloc = context.read<LegalStatementBloc>();
    final consentConfirmationBloc = context.read<ConsentConfirmationBloc>();
    final mentalHealthBloc = context.read<MentalQuestionsBloc>();
    final authTokenManager = GetIt.instance<AuthTokenManager>();
    authBloc.add(const AuthenticationEvent.connectSockets());
    context.read<AppUpdateBloc>().add(const AppUpdateEvent.getVersion());

    _appRouter = AppRouter(
      navigatorKey: kNavigatorKey,
      proxyGuard: ProxyGuard(authTokenManager),
      introGuard: IntroGuard(
        authBloc,
        onboardingBloc,
        consentConfirmationBloc,
        legalStatementBloc,
        mentalHealthBloc,
        authTokenManager,
      ),
      genderPrefsGuard: GenderPrefsGuard(),
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
          FirebaseNavigatorObserver(
            analytics: analytics,
            userId: context.read<AuthenticationBloc>().state.data.accountId,
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
