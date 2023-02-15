import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';

class ProxyGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (const String.fromEnvironment('FLAVOR', defaultValue: 'dev') == 'dev') {
      resolver.next(true);
    } else {
      router.replaceNamed(AppRoutes.intro);
    }
  }
}
