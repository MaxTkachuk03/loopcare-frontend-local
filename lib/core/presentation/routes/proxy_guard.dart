import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';

class ProxyGuard extends AutoRouteGuard {
  AuthenticationCubit authenticationCubit;
  AuthTokenManager authTokenManager;

  ProxyGuard(this.authenticationCubit, this.authTokenManager);

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (const String.fromEnvironment('FLAVOR', defaultValue: 'dev') == 'dev') {
      resolver.next(true);
    } else {
      if (authenticationCubit.state.isAuthenticated) {
        final accessTokenPresent = await authTokenManager.getAccessToken();
        final refreshTokenPresent = await authTokenManager.getRefreshToken();
        String route;
        if (!((accessTokenPresent?.isNotEmpty ?? false) && (refreshTokenPresent?.isNotEmpty ?? false))) {
          route = AppRoutes.login;
        } else if (authenticationCubit.state.hasActiveSubscription) {
          route = AppRoutes.home;
        } else {
          route = AppRoutes.subscription;
        }
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
