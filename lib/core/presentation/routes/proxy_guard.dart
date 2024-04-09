import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/injection.dart';

class ProxyGuard extends AutoRouteGuard {
  AuthTokenManager authTokenManager;

  ProxyGuard(this.authTokenManager);

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final account = getIt<SharedStorageService>().account;

    if (const String.fromEnvironment('FLAVOR', defaultValue: 'dev') == 'dev') {
      resolver.next(true);
    } else {
      if (account != null) {
        final accessToken = await authTokenManager.getAccessToken() ?? '';
        final refreshToken = await authTokenManager.getRefreshToken() ?? '';
        String route;
        if (accessToken.isEmpty || refreshToken.isEmpty) {
          route = AppRoutes.login;
        }

        //Todo hide subscription flow LOOPCARE-2197
        else if (account.hasActiveSubscription) {
          route = AppRoutes.home;
        } else {
          route = AppRoutes.subscription;
        }

        MixpanelEventService.instance.trackVisit(
          "${AppMixpanelEvents.appRote}:  $route",
          userId: account.id,
        );
        router.replaceNamed(route);

        return;
      } else {
        router.replaceNamed(AppRoutes.preIntro);
        MixpanelEventService.instance.trackVisit(
          "${AppMixpanelEvents.appRote}:  ${AppRoutes.preIntro}",
          userId: account?.id ?? -1,
        );
      }
    }
  }
}
