import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/gender_preferences.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/sex_type.dart';

class GroupPreferencesForm extends StatelessWidget {
  const GroupPreferencesForm({super.key});

  @override
  Widget build(BuildContext context) {
    return WhiteBox(
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, accountState) {
          if (accountState.groupingState == null) return const SizedBox.shrink();

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
                      onButtonPressed: () => context.router.pop(),
                    ),
                  );
                },
                updated: (s) {
                  final preferences = s.data.genderPreferences;
                  final gender = accountState.gender;
                  final showGenderPreference = (gender == SexType.female || gender == SexType.male);

                  if (accountState.groupingState == UserGroupingState.grouped) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PartOfGroup(),
                        const SizedBox(height: 16.0),
                        const DividerLight(),
                        const SizedBox(height: 16.0),
                        TappedItem(
                          title: LocalizedTexts.yourNickname,
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
                        title: LocalizedTexts.timezone,
                        subTitle: s.data.timezone ?? '',
                        onPressHandler: () => _onTimezoneTap(context),
                      ),
                      const SizedBox(height: 16.0),
                      const DividerLight(),
                      const SizedBox(height: 16.0),
                      TappedItem(
                        title: LocalizedTexts.yourNickname,
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
    context.read<GroupPreferencesBloc>().add(const GroupPreferencesEvent.leaveGroup());
  }

  _onCancelProcessingPressed(BuildContext context) {
    context.read<GroupPreferencesBloc>().add(const GroupPreferencesEvent.cancelGrouping());
  }
}
