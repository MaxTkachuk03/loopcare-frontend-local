import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped_no_timeslots.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped_not_signed.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/no_group.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/session_card.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';

class Grouped extends StatelessWidget {
  const Grouped({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicsBloc, TopicsState>(
      builder: (context, state) {
        return state.maybeMap(
          error: (errorState) {
            final error = errorState.data.error;

            return Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: ErrorScreen(
                smallVersion: true,
                error: error!,
                onButtonPressed: () => context.read<TopicsBloc>().add(const TopicsEvent.fetchTopics()),
              ),
            );
          },
          loading: (_) => const SizedBox(height: 100, child: Loader()),
          orElse: () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.data.isGroupsOnWeekAvailable)
                  CustomText.bitter600(
                    state.data.isHappeningNow
                        ? LocalizedTexts.happeningNow.tr()
                        : LocalizedTexts.comingUpThisWeek.tr(),
                    style: context.textTheme.bodyLarge,
                  ),
                const SizedBox(height: 16.0),
                if (!state.data.timeSlotsAvailable &&
                    !state.data.isSigned &&
                    state.data.isGroupsOnWeekAvailable)
                  const GroupedNoTimeslots(),
                if (state.data.timeSlotsAvailable && !state.data.isSigned)
                  GroupedNotSigned(
                    topicName: state.data.weekTopicName,
                    image: state.data.thisWeekTopicsImage,
                  ),
                if (!state.data.isGroupsOnWeekAvailable) const NoGroup(),
                if (state.data.isSigned && state.data.isGroupsOnWeekAvailable)
                  SessionCard(
                    topicName: state.data.weekTopicName,
                    startDate: state.data.signedGroupSessionStartTime ?? DateTime.now(),
                    endDate: state.data.signedGroupSessionsEndTime ?? DateTime.now(),
                    preparationMaterialsAvailable: !state.data.signedGroupSessionsCancelled,
                    isCancelledOrMissed: state.data.signedGroupSessionsCancelledOrMissed,
                    isCancelled: state.data.signedGroupSessionsCancelled,
                    isMissed: state.data.signedGroupSessionsMissed,
                    image: state.data.thisWeekTopicsImage,
                    isFinished: state.data.signedGroupSessionFinished,
                    timeSlotsAvailable: state.data.timeSlotsAvailable,
                    sessionMightBeCancelled: state.data.signedGroupSessionsMightBeCancelled,
                    isHappeningNow: state.data.isHappeningNow,
                    isCanJoin: state.data.isCanJoin,
                    minMemberCount: state.data.signedGroupSession?.minMemberCount ?? 0,
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
