import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/group_sessions/domain/group_session_status.dart';

part 'timeslot_card.freezed.dart';

@freezed
class TimeslotCardType with _$TimeslotCardType {
  const factory TimeslotCardType.available() = Available;

  const factory TimeslotCardType.passed() = Passed;

  const factory TimeslotCardType.full() = Full;

  const factory TimeslotCardType.cancelled() = Cancelled;
}

class TimeslotCard extends StatefulWidget {
  final GroupSession groupSession;
  final int duration;

  const TimeslotCard({
    super.key,
    required this.groupSession,
    required this.duration,
  });

  @override
  State<TimeslotCard> createState() => _TimeslotCardState();
}

class _TimeslotCardState extends State<TimeslotCard> {
  late TimeslotCardType _type;

  @override
  void initState() {
    final isFullSession = widget.groupSession.memberCount == widget.groupSession.maxMemberCount;
    final isPassed = widget.groupSession.status == GroupSessionStatus.finished ||
        widget.groupSession.startDate.toLocal().isBefore(DateTime.now());

    final isCancelled = widget.groupSession.status == GroupSessionStatus.cancelled;

    if (isFullSession) {
      _type = const TimeslotCardType.full();
    } else if (isPassed) {
      _type = const TimeslotCardType.passed();
    } else if (isCancelled) {
      _type = const TimeslotCardType.cancelled();
    } else {
      _type = const TimeslotCardType.available();
    }

    super.initState();
  }

  Color get textColor => _type.maybeMap(
        available: (_) => AppColors.blueDarker,
        orElse: () => AppColors.greyLight,
      );

  Color get borderColor => _type.maybeMap(
        available: (_) => AppColors.blueDarker,
        orElse: () => AppColors.greyLight,
      );

  String get description => _type.map(
        available: (_) => LocalizedTexts.numberOfAvailableSeats.tr({
          'number': '${widget.groupSession.availableSeatsAmount}',
          'totalNumber': '${widget.groupSession.maxMemberCount}',
        }),
        passed: (_) => LocalizedTexts.passedSession.tr(),
        cancelled: (_) => LocalizedTexts.cancelledSession.tr(),
        full: (_) => LocalizedTexts.noMoreSeatAvailable.tr(),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _type == const TimeslotCardType.available() ? _onSessionPressed : null,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: borderColor,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.w600(
                  widget.groupSession.startDate.toLocal().weekdayString,
                  style: context.textTheme.titleMedium?.copyWith(color: textColor),
                ),
                CustomText.w600(
                  widget.groupSession.startDate.toLocal().fullDateWithHyphen,
                  style: context.textTheme.titleMedium?.copyWith(color: textColor),
                ),
              ],
            ),
            const SizedBox(width: 22.0),
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: borderColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.w600(
                    LocalizedTexts.fromTo.tr(
                      {
                        'startTime': widget.groupSession.localStartTime.timeHoursMinutes24,
                        'endTime': widget.groupSession.localEndTime.timeHoursMinutes24,
                      },
                    ),
                    style: context.textTheme.titleMedium?.copyWith(color: textColor),
                  ),
                  CustomText.w600(
                    description,
                    style: context.textTheme.bodySmall?.copyWith(color: textColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onSessionPressed() {
    const AnalyticsEventService().logEvent(eventName: AnalyticsEvents.userSignedUpForSession);
    context.read<TopicsBloc>().add(
          TopicsEvent.signUpToSession(widget.groupSession.id),
        );
  }
}
