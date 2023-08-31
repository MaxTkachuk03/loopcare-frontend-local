import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped_no_timeslots.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped_not_signed.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped_signed.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/no_group.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';

class Grouped extends StatelessWidget {
  const Grouped({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicsBloc, TopicsState>(
      builder: (context, state) {
        var isHappeningNow = false;
        if (state.data.isSigned) {
          var sessionStartDate = state.data.signedGroupSessionStartTime;
          var sessionEndDate = state.data.signedGroupSessionsEndTime;
          var nowMoment = DateTime.now();
          if (sessionStartDate != null && sessionEndDate != null) {
            if (nowMoment.isAfter(sessionStartDate) && nowMoment.isBefore(sessionEndDate)) {
              isHappeningNow = true;
            }
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.data.isGroupsOnThisWeekAvailable)
              Text(
                isHappeningNow
                    ? LocalizedTexts.happeningNow.tr().toUpperCase()
                    : LocalizedTexts.comingUpThisWeek.tr().toUpperCase(),
                style: const TextStyle(
                  fontSize: ThemeConstants.fontSize12,
                  color: AppColors.greyLabel,
                ),
              ),
            const SizedBox(height: 16.0),
            if (!state.data.timeSlotsAvailable &&
                !state.data.isSigned &&
                state.data.isGroupsOnThisWeekAvailable)
              const GroupedNoTimeslots(),
            if (state.data.timeSlotsAvailable && !state.data.isSigned)
              GroupedNotSigned(topicName: state.data.topicName),
            if (state.data.isSigned && state.data.isGroupsOnThisWeekAvailable)
              GroupedSigned(
                signedGroupSessions: state.data.signedGroupSession!,
                topicName: state.data.topicName,
                startDate: state.data.signedGroupSessionStartTime ?? DateTime.now(),
                endDate: state.data.signedGroupSessionsEndTime ?? DateTime.now(),
                preparationMaterialsAvailable: !state.data.signedGroupSessionsCancelled,
                isCancelledOrMissed: state.data.signedGroupSessionsCancelledOrMissed,
                isCancelled: state.data.signedGroupSessionsCancelled,
                isMissed: state.data.signedGroupSessionsMissed,
                timeSlotsAvailable: state.data.timeSlotsAvailable,
                sessionMightBeCancelled: state.data.signedGroupSessionsMightBeCancelled,
                isHappeningNow: isHappeningNow,
              ),
            if (!state.data.isGroupsOnThisWeekAvailable) const NoGroup(),
          ],
        );
      },
    );
  }
}
