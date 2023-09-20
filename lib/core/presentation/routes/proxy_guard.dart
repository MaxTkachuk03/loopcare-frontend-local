import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';

import '../../../features/authentication/application/authentication_cubit.dart';

class ProxyGuard extends AutoRouteGuard {
  AuthenticationCubit authenticationCubit;

  ProxyGuard(
    this.authenticationCubit,
  );

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    // if (authenticationCubit.state.isAuthenticated) {
    //   await authenticationCubit.updateAccessToken();
    //   await authenticationCubit.updateRefreshToken();
    // }
    if (const String.fromEnvironment('FLAVOR', defaultValue: 'dev') == 'dev') {
      resolver.next(true);
    } else {
      if (authenticationCubit.state.isAuthenticated) {
        final route =
            authenticationCubit.state.isPreferencesComplete ? AppRoutes.home : AppRoutes.preferencesOverview;
        MixpanelEventService.instance.trackVisit(
          "${AppMixpanelEvents.appRote}:  $route",
          userId: authenticationCubit.state.id,
        );
        router.replaceNamed(route);
        return;
      } else {
        router.replaceNamed(AppRoutes.preIntro);
        MixpanelEventService.instance.trackVisit(
          "${AppMixpanelEvents.appRote}:  ${AppRoutes.preIntro}",
          userId: authenticationCubit.state.id,
        );
      }
    }
  }
}
