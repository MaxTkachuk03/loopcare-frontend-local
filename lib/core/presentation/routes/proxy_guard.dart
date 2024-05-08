import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/injection.dart';

class ProxyGuard extends AutoRouteGuard {
  ProxyGuard();

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    resolver.next(kIsDev);
  }
}
