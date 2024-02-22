import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/can_not_find_group.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/grouped.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/not_grouped.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/waiting_in_pool.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class GroupPreferencesPage extends StatefulWidget {
  const GroupPreferencesPage({super.key});

  @override
  State<GroupPreferencesPage> createState() => _GroupPreferencesPageState();
}

class _GroupPreferencesPageState extends State<GroupPreferencesPage> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthenticationCubit>().state;
    final timezone = context.read<GroupPreferencesBloc>().state.data.timezone;
    final nickname = context.read<GroupPreferencesBloc>().state.data.nickname;
    final genderPreferences = context.read<GroupPreferencesBloc>().state.data.genderPreferences;

    context.read<GroupPreferencesBloc>().add(
          GroupPreferencesEvent.setInitialData(
            value: authState.groupingState == UserGroupingState.grouped ? YesNoAnswer.yes : YesNoAnswer.no,
            gender: genderPreferences ?? authState.genderPreferences,
            nickname: nickname ?? authState.nickname,
            timezone: timezone ?? authState.timezone,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blue(
      needBottomFacture: true,
      appBar: CustomAppBar.blue(
        leading: CustomFilledIconButton.leadingBlueLighter(),
        title: LocalizedTexts.groupPreferences.translation,
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: BlocBuilder<GroupPreferencesBloc, GroupPreferencesState>(
                builder: (context, groupPrefsState) {
                  if (groupPrefsState.data.isLoading) {
                    return const Loader();
                  }

                  if (groupPrefsState.data.error != null) {
                    return SizedBox(
                      width: double.infinity,
                      child: ErrorScreen(
                        error: groupPrefsState.data.error!,
                      ),
                    );
                  }

                  return BlocBuilder<AuthenticationCubit, AuthenticationState>(
                      builder: (BuildContext context, state) {
                    if (state.groupingState == null) return const SizedBox.shrink();
                    if (state.groupingState == UserGroupingState.unlockedPreferences) {
                      return const NotGrouped();
                    }
                    if (state.groupingState == UserGroupingState.refused) return const NotGrouped();
                    if (state.groupingState == UserGroupingState.left) return const NotGrouped();
                    if (state.groupingState == UserGroupingState.waitingInPool) return const WaitingInPool();
                    if (state.groupingState == UserGroupingState.grouped) return const Grouped();
                    if (state.groupingState == UserGroupingState.loopedOnGenderPreferences) {
                      return const CanNotFindGroup();
                    }

                    return const SizedBox.shrink();
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
