import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/injection.dart';

class UnlockFeatureGuard extends AutoRouteGuard {
  const UnlockFeatureGuard();

  // TODO removed preferences logic before lesson complete screen as per discussion with Diana 04.07.2024
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final account = getIt<SharedStorageService>().account;
    final unlocksFeature = getIt<RiverBloc>().state.data.activeModuleItem?.unlocksFeature ?? [];

    for (final feature in unlocksFeature) {
      if (!(account?.isFeatureUnlocked(feature) ?? false)) {
        _unlockFeature(feature);
      }
    }

    // if (unlocksFeature == ExtraActionTypes.setupGroupingPreferences &&
    //     !(account?.isGroupSessionsUnlocked ?? false)) {
    //   _unlockFeature(UnlockedFeatureType.grouping);
    //
    //   getIt<GroupPreferencesBloc>()
    //       .add(const GroupPreferencesEvent.changeGroupPrefsMode(GroupPrefsMode.groupingLesson));
    //
    //   router.push(SupportGroupIntroRoute(streamType: streamType));
    //   return;
    // }
    //
    // if (extraAction == ExtraActionTypes.unlockFoodLogging &&
    //     !(account?.isFoodLoggingUnlocked ?? false)) {
    //   _unlockFeature(UnlockedFeatureType.foodLogging);
    //
    //   router.push(LessonCompleteFoodPreferencesRoute(streamType: streamType));
    //   return;
    // }
    //
    // if (extraAction == ExtraActionTypes.unlockPhysicalActivities &&
    //     !(account?.isPhysicalActivitiesUnlocked ?? false)) {
    //   _unlockFeature(UnlockedFeatureType.physicalActivity);
    //
    //   router.push(PhysicalPreferencesIntroRoute(streamType: streamType));
    //   return;
    // }

    resolver.next(true);
  }

  void _unlockFeature(UnlockedFeatureType feature) {
    getIt<AuthenticationBloc>().add(AuthenticationEvent.unlockFeature(feature));
  }
}
