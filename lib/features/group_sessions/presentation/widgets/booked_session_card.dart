import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/preparation_materials.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';

class BookedSessionCard extends StatelessWidget {
  final GroupSession groupSession;
  final int duration;

  const BookedSessionCard({
    Key? key,
    required this.groupSession,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: AppColors.bgGreen,
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 42,
                height: 42.0,
                child: ImageIcon(
                  AppIcons.checkmark,
                  color: AppColors.blueMid,
                  size: 24.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${groupSession.startDate.toLocal().weekdayString} ${groupSession.startDate.toLocal().fullDateWithHyphen}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.darkGreen),
                  ),
                  Text(
                    LocalizedTexts.fromToLower,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.darkGreen),
                  ).tr(
                    namedArgs: {
                      'startTime': groupSession.startDate.toLocal().timeHoursMinutes24,
                      'endTime': groupSession.startDate
                          .toLocal()
                          .add(Duration(seconds: duration))
                          .timeHoursMinutes24,
                    },
                  ),
                  Text(
                    LocalizedTexts.numberOfAvailableSeats.translateWithNamedArgs({
                      'number': '${groupSession.availableSeatsAmount}',
                      'totalNumber': '${groupSession.maxMemberCount}',
                    }),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.darkGreen),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const PreparationMaterials(),
          const SizedBox(height: 16.0),
          OutlinedRoundedButton(
            text: LocalizedTexts.cancelBooking.translation,
            borderColor: AppColors.greyMid,
            isRegularText: true,
            onPressed: () => _onCancelPressed(context),
          ),
        ],
      ),
    );
  }

  _onCancelPressed(BuildContext context) {
    context.read<TopicsBloc>().add(TopicsEvent.signOutFromSession(groupSession.id));
  }
}
