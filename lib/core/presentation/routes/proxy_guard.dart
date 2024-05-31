import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/build_type.dart';

class ProxyGuard extends AutoRouteGuard {
  ProxyGuard();

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    resolver.next(kIsDev);
  }
}
