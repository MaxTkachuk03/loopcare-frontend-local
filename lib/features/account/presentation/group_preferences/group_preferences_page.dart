import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/grouped.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/can_not_find_group.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/not_grouped.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/waiting_in_pool.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/gender_preferences.dart';

class GroupPreferencesPage extends StatefulWidget {
  const GroupPreferencesPage({Key? key}) : super(key: key);

  @override
  State<GroupPreferencesPage> createState() => _GroupPreferencesPageState();
}

class _GroupPreferencesPageState extends State<GroupPreferencesPage> {
  @override
  void initState() {
    final authState = context.read<AuthenticationCubit>().state;

    context.read<GroupPreferencesBloc>().add(GroupPreferencesEvent.setInitialData(
          value: authState.groupingState == UserGroupingState.notGrouped ? YesNoAnswer.no : YesNoAnswer.no,
          gender: authState.genderPreferences ?? GenderPreferences.noPreference,
          nickname: authState.nickname ?? '',
          timezone: authState.timezone ?? '',
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        title: LocalizedTexts.groupPreferences.translation,
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (BuildContext context, state) {
                if (state.groupingState == null) return const SizedBox.shrink();

                if (state.groupingState == UserGroupingState.notGrouped) return const NotGrouped();
                if (state.groupingState == UserGroupingState.refused) return const NotGrouped();
                if (state.groupingState == UserGroupingState.left) return const NotGrouped();
                if (state.groupingState == UserGroupingState.waitingInPool) return const WaitingInPool();
                if (state.groupingState == UserGroupingState.grouped) return const Grouped();
                if (state.groupingState == UserGroupingState.longWaitingInPool) {
                  return const CanNotFindGroup();
                }

                return const SizedBox.shrink();
              }),
            ),
          ),
        ),
      ),
    );
  }
}
