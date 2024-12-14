import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/injection.dart';

class GenderPrefsGuard extends AutoRouteGuard {
  const GenderPrefsGuard();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final gender = getIt<SharedStorageService>().account?.gender;

    if (gender != GenderType.other) {
      resolver.next(true);
    } else {
      router.pushNamed(AppRoutes.timezone);
    }
  }
}
