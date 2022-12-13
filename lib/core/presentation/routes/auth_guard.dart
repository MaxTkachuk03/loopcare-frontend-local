import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  bool isAuthorized;

  AuthGuard(this.isAuthorized);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (isAuthorized) {
      resolver.next(true);
    } else {
      await router.pushNamed(AppRoutes.login);
      resolver.next(isAuthorized);
    }
  }
}
