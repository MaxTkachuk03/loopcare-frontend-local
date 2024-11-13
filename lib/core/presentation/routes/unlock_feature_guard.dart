import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/injection.dart';

class UnlockFeatureGuard extends AutoRouteGuard {
  const UnlockFeatureGuard();

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final account = getIt<SharedStorageService>().account;
    final unlocksFeature = getIt<RiverBloc>().state.data.activeModuleItem?.unlocksFeature ?? [];

    for (final feature in unlocksFeature) {
      if (!(account?.isFeatureUnlocked(feature) ?? false)) {
        _unlockFeature(feature);
      }
    }

    resolver.next(true);
  }

  void _unlockFeature(UnlockedFeatureType feature) {
    getIt<AuthenticationBloc>().add(AuthenticationEvent.unlockFeature(feature));
  }
}
