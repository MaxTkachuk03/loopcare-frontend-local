import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';

import '../../../features/authentication/application/authentication_cubit.dart';

class ProxyGuard extends AutoRouteGuard {
  AuthenticationCubit authenticationCubit;

  ProxyGuard(
    this.authenticationCubit,
  );

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (const String.fromEnvironment('FLAVOR', defaultValue: 'dev') == 'dev') {
      resolver.next(true);
    } else {
      if (authenticationCubit.state.isAuthenticated) {
        final route = authenticationCubit.state.isPreferencesComplete ? AppRoutes.home : AppRoutes.preferencesOverview;
        router.replaceNamed(route);
        return;
      } else {
        router.replaceNamed(AppRoutes.intro);
      }
    }
  }
}
