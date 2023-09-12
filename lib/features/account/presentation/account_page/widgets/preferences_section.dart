import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_frequency.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_type.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({Key? key}) : super(key: key);

  void _onFoodHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.foodPreferences);
  }

  void _onPhysicalActivitiesHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.physicalActivitiesFrequency);
  }

  void _onGroupSessionsHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.groupPreferences);
  }

  String _physicalActivitiesPreferencesSubtitle(PhysicalActivitiesPreferencesState state) {
    var target = "";
    var perWeek = "";
    var frequency = "";
    if (state.data.currentTrainingFrequency != null) {
      frequency = state.data.currentTrainingFrequency?.label ?? "";
      if (state.data.currentTrainingFrequency != PhysicalActivitiesFrequency.notAble) {
        target = state.data.currentTrainingTargets?.label ?? "";
        if (target.isNotEmpty) {
          target = "$target, ";
        }
        perWeek = LocalizedTexts.perWeek.translation;
      }
    }

    return "$target$frequency $perWeek";
  }

  String _groupSessionsSubtitle(AuthenticationState state) {
    LocalizedTexts.partOfGroup.translation;
    var grouped = state.unlockedFeatures.contains(UnlockedFeatureType.grouping)
        ? LocalizedTexts.yes.translation.capitalize()
        : LocalizedTexts.no.translation.capitalize();

    return "${LocalizedTexts.partOfGroup.translation}: $grouped";
  }

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(
        children: [
          const SectionTitle(title: LocalizedTexts.preferences),
          SectionItem(title: LocalizedTexts.food, onPressHandler: () => _onFoodHandler(context)),
          const SizedBox(height: 16.0),
          const Divider(height: 1.0, color: AppColors.yellowLight),
          const SizedBox(height: 16.0),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return BlocBuilder<PhysicalActivitiesPreferencesBloc, PhysicalActivitiesPreferencesState>(
                builder: (context, physicalActivitiesPreferencesState) {
                  return SectionItem(
                      title: LocalizedTexts.physicalExersises,
                      subTitle: _physicalActivitiesPreferencesSubtitle(physicalActivitiesPreferencesState),
                      onPressHandler: state.unlockedFeatures.contains(UnlockedFeatureType.physicalActivities)
                          ? () => _onPhysicalActivitiesHandler(context)
                          : null);
                },
              );
            },
          ),
          const SizedBox(height: 16.0),
          const Divider(height: 1.0, color: AppColors.yellowLight),
          const SizedBox(height: 16.0),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return SectionItem(
                title: LocalizedTexts.groupSessions,
                subTitle: _groupSessionsSubtitle(state),
                onPressHandler: state.unlockedFeatures.contains(UnlockedFeatureType.grouping)
                    ? () => _onGroupSessionsHandler(context)
                    : null,
              );
            },
          ),
          const SizedBox(height: 16.0),
          const Divider(height: 1.0, color: AppColors.yellowLight),
          const SizedBox(height: 16.0),
          SectionItem(title: LocalizedTexts.diabetes, onPressHandler: () {}),
        ],
      ),
    );
  }
}
