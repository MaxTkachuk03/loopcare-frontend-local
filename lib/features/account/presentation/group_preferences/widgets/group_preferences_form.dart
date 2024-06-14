import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/divider_light.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/part_of_group.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/tapped_item.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/white_box.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/core/domain/account/gender_preferences.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';
import 'package:loopcare_frontend/injection.dart';

class GroupPreferencesForm extends StatelessWidget {
  const GroupPreferencesForm({super.key});

  @override
  Widget build(BuildContext context) {
    return WhiteBox(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, accountState) {
          if (accountState.data.groupingState == null) return const SizedBox.shrink();

          return BlocBuilder<GroupPreferencesBloc, GroupPreferencesState>(
            builder: (context, state) {
              return state.maybeMap(
                orElse: () => const SizedBox.shrink(),
                error: (errorState) {
                  if (state.data.isLoading) return const Loader();

                  final error = errorState.data.error;

                  return Center(
                    child: ErrorScreen(
                      error: error!,
                      onButtonPressed: context.router.maybePop,
                    ),
                  );
                },
                updated: (s) {
                  final preferences = s.data.genderPreferences;
                  final gender = accountState.data.gender;
                  final showGenderPreference = (gender != GenderType.other);

                  if (accountState.data.groupingState == UserGroupingState.grouped) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PartOfGroup(),
                        const SizedBox(height: 16.0),
                        const DividerLight(),
                        const SizedBox(height: 16.0),
                        TappedItem(
                          title: LocalizedTexts.yourNickname.tr(),
                          subTitle: s.data.nickname ?? '',
                          onPressHandler: () => _onNicknamePreferencesTap(context),
                        ),
                        const SizedBox(height: 16.0),
                        const DividerLight(),
                        const SizedBox(height: 16.0),
                        CustomOutlinedButton.coralFullWidth(
                          label: LocalizedTexts.leaveGroup.tr(),
                          onPressed: () => _onLeaveGroupPressed(context),
                        )
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showGenderPreference)
                        TappedItem(
                          title: LocalizedTexts.genderPreference.tr(),
                          subTitle: preferences != null ? preferences.label : '',
                          onPressHandler: () => _onGenderPreferencesTap(context),
                        ),
                      if (showGenderPreference) const SizedBox(height: 16.0),
                      if (showGenderPreference) const DividerLight(),
                      const SizedBox(height: 16.0),
                      TappedItem(
                        title: LocalizedTexts.timezone.tr(),
                        subTitle: s.data.timezone ?? '',
                        onPressHandler: () => _onTimezoneTap(context),
                      ),
                      const SizedBox(height: 16.0),
                      const DividerLight(),
                      const SizedBox(height: 16.0),
                      TappedItem(
                        title: LocalizedTexts.yourNickname.tr(),
                        subTitle: s.data.nickname ?? '',
                        onPressHandler: () => _onNicknamePreferencesTap(context),
                      ),
                      const SizedBox(height: 16.0),
                      const DividerLight(),
                      const SizedBox(height: 16.0),
                      const PartOfGroup(),
                      const SizedBox(height: 16.0),
                      const DividerLight(),
                      const SizedBox(height: 16.0),
                      CustomOutlinedButton.blueFullWidth(
                        label: LocalizedTexts.iNoLongerWantToJoin.tr(),
                        onPressed: () => _onCancelProcessingPressed(context),
                      )
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _onGenderPreferencesTap(BuildContext context) {
    context
      ..read<GroupPreferencesBloc>()
          .add(const GroupPreferencesEvent.changeGroupPrefsMode(GroupPrefsMode.singlePage))
      ..router.push(GenderPreferencesRoute(fromLessonComplete: false));
  }

  void _onTimezoneTap(BuildContext context) {
    context
      ..read<GroupPreferencesBloc>()
          .add(const GroupPreferencesEvent.changeGroupPrefsMode(GroupPrefsMode.singlePage))
      ..router.push(TimezonePreferencesRoute(fromLessonComplete: false));
  }

  void _onNicknamePreferencesTap(BuildContext context) {
    context
      ..read<GroupPreferencesBloc>()
          .add(const GroupPreferencesEvent.changeGroupPrefsMode(GroupPrefsMode.singlePage))
      ..router.push(NicknamePreferencesRoute(fromLessonComplete: false));
  }

  _onLeaveGroupPressed(BuildContext context) {
    final account = getIt<SharedStorageService>().account;
    final groupId = account?.groupId ?? -1;

    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userLeaveGroup,
      parameters: {
        CustomDefinitions.groupId: groupId.toString(),
        CustomDefinitions.type: account?.genderPreference?.name ?? '',
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
    context.read<GroupPreferencesBloc>().add(const GroupPreferencesEvent.leaveGroup());
  }

  _onCancelProcessingPressed(BuildContext context) {
    context.read<GroupPreferencesBloc>().add(const GroupPreferencesEvent.cancelGrouping());
  }
}
