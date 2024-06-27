import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/domain/unlock_config/unlock_feature/unlock_feature.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';
import 'package:loopcare_frontend/injection.dart';

class UnlockFeatureGuard extends AutoRouteGuard {
  const UnlockFeatureGuard();

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final args = router.current.args as dynamic;
    final streamType = args.streamType as RiverModuleStreamType;

    final account = getIt<SharedStorageService>().account;
    final extraAction = getIt<EducationLessonBloc>().state.data.extraAction;

    if (extraAction == ExtraActionTypes.setupGroupingPreferences &&
        !(account?.isGroupSessionsUnlocked ?? false)) {
      _unlockFeature(UnlockedFeatureType.grouping);

      getIt<GroupPreferencesBloc>()
          .add(const GroupPreferencesEvent.changeGroupPrefsMode(GroupPrefsMode.groupingLesson));

      router.push(SupportGroupIntroRoute(streamType: streamType));
      return;
    }

    if (extraAction == ExtraActionTypes.unlockFoodLogging &&
        !(account?.isFoodLoggingUnlocked ?? false)) {
      _unlockFeature(UnlockedFeatureType.foodLogging);

      router.push(LessonCompleteFoodPreferencesRoute(streamType: streamType));
      return;
    }

    if (extraAction == ExtraActionTypes.unlockPhysicalActivities &&
        !(account?.isPhysicalActivitiesUnlocked ?? false)) {
      _unlockFeature(UnlockedFeatureType.physicalActivities);

      router.push(PhysicalPreferencesIntroRoute(streamType: streamType));
      return;
    }

    resolver.next(true);
  }

  void _unlockFeature(UnlockedFeatureType feature) {
    getIt<AuthenticationBloc>().add(
      AuthenticationEvent.unlockFeature(
        UnlockFeature(
          feature: feature.name,
          unlocked: true,
          subFeatures: null,
        ),
      ),
    );
  }
}
