import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
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
}

class TimeslotCard extends StatefulWidget {
  final GroupSession groupSession;
  final int duration;

  const TimeslotCard({
    Key? key,
    required this.groupSession,
    required this.duration,
  }) : super(key: key);

  @override
  State<TimeslotCard> createState() => _TimeslotCardState();
}

class _TimeslotCardState extends State<TimeslotCard> {
  late TimeslotCardType _type;

  @override
  void initState() {
    final isFullSession = widget.groupSession.memberCount == widget.groupSession.maxMemberCount;

    if (isFullSession) {
      _type = const TimeslotCardType.full();
    } else if (widget.groupSession.status == GroupSessionStatus.finished ||
        widget.groupSession.startDate.toLocal().isBefore(DateTime.now())) {
      _type = const TimeslotCardType.passed();
    } else {
      _type = const TimeslotCardType.available();
    }

    super.initState();
  }

  Color get textColor => _type.maybeMap(
        available: (_) => AppColors.darkGreen,
        orElse: () => AppColors.greyLabel,
      );

  Color get borderColor => _type.maybeMap(
        available: (_) => AppColors.darkGreen,
        orElse: () => AppColors.greyMid,
      );

  String get description => _type.map(
        available: (_) => LocalizedTexts.numberOfAvailableSeats.translateWithNamedArgs({
          'number': '${widget.groupSession.availableSeatsAmount}',
          'totalNumber': '${widget.groupSession.maxMemberCount}',
        }),
        passed: (_) => LocalizedTexts.passedSession.translation,
        full: (_) => LocalizedTexts.noMoreSeatAvailable.translation,
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
                Text(
                  widget.groupSession.startDate.toLocal().weekdayString,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: textColor),
                ),
                Text(
                  widget.groupSession.startDate.toLocal().fullDateWithHyphen,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: textColor),
                ),
              ],
            ),
            const SizedBox(width: 22.0),
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: AppColors.yellowLight,
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocalizedTexts.fromTo,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: textColor),
                  ).tr(
                    namedArgs: {
                      'startTime': widget.groupSession.localStartTime.timeHoursMinutes24,
                      'endTime': widget.groupSession.localEndTime.timeHoursMinutes24,
                    },
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
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
    context.read<TopicsBloc>().add(
          TopicsEvent.signUpToSession(widget.groupSession.id),
        );
  }
}
