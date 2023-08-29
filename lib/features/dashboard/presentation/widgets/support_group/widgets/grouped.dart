import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped_no_timeslots.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped_not_signed.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped_signed.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';

class Grouped extends StatelessWidget {
  final bool nextWeek;

  const Grouped({
    Key? key,
    this.nextWeek = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicsBloc, TopicsState>(
      builder: (context, state) {
        var isHappeningNow = false;
        if (state.data.isSigned) {
          var sessionStartDate = state.data.signedGroupSession!.startDate;
          var sessionEndDate = state.data.signedGroupSessionsEndDate;
          var nowMoment = DateTime.now();
          if (nowMoment.isAfter(sessionStartDate) && nowMoment.isBefore(sessionEndDate)) {
            isHappeningNow = true;
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nextWeek
                  ? LocalizedTexts.comingUpNextWeek.tr().toUpperCase()
                  : isHappeningNow
                      ? LocalizedTexts.happeningNow.tr().toUpperCase()
                      : LocalizedTexts.comingUpThisWeek.tr().toUpperCase(),
              style: const TextStyle(
                fontSize: ThemeConstants.fontSize12,
                color: AppColors.greyLabel,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            if (!state.data.timeSlotsAvailable) const GroupedNoTimeslots(),
            if (state.data.timeSlotsAvailable && !state.data.isSigned)
              GroupedNotSigned(topicName: state.data.topicName),
            if (state.data.isSigned)
              GroupedSigned(
                signedGroupSessions: state.data.signedGroupSession!,
                topicName: state.data.topicName,
                endDate: state.data.signedGroupSessionsEndDate,
                preparationMaterialsAvailable: !state.data.signedGroupSessionsCancelled,
                isCancelledOrMissed: state.data.signedGroupSessionsCancelledOrMissed,
                isCancelled: state.data.signedGroupSessionsCancelled,
                isMissed: state.data.signedGroupSessionsMissed,
                timeSlotsAvailable: state.data.timeSlotsAvailable,
                sessionMightBeCancelled: state.data.signedGroupSessionsMightBeCancelled,
                isHappeningNow: isHappeningNow,
              ),
          ],
        );
      },
    );
  }
}
