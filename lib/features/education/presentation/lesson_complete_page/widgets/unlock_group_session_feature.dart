import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/feature_unlock.dart';

class UnlockGroupSessionFeature extends StatelessWidget {
  const UnlockGroupSessionFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final body = state.groupingState == UserGroupingState.waitingInPool
            ? LocalizedTexts.waitingForGroupCompletedLesson
            : LocalizedTexts.notJoinedToGroupCompletedLesson;

        return FeatureUnlock(title: LocalizedTexts.groupSessionsUnlocked.tr(), body: body);
      },
    );
  }
}
