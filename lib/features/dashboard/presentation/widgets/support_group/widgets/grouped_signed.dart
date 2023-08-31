// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped_signed_cancelled_booking.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped_signed_might_cancelled.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/preparation_materials.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session.dart';

class GroupedSigned extends StatelessWidget {
  final GroupSession signedGroupSessions;

  final String topicName;
  final DateTime startDate;
  final DateTime endDate;
  final bool preparationMaterialsAvailable;
  final bool isCancelledOrMissed;
  final bool isCancelled;
  final bool isMissed;
  final bool timeSlotsAvailable;
  final bool sessionMightBeCancelled;
  final bool isHappeningNow;

  const GroupedSigned({
    Key? key,
    required this.signedGroupSessions,
    required this.topicName,
    required this.startDate,
    required this.endDate,
    required this.preparationMaterialsAvailable,
    required this.isCancelledOrMissed,
    required this.isCancelled,
    required this.isMissed,
    required this.timeSlotsAvailable,
    required this.sessionMightBeCancelled,
    required this.isHappeningNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _onMoreInfoPressed(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(topicName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        )).tr(),
              ),
              const ImageIcon(AppIcons.arrow, color: AppColors.greyLabel),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        IntrinsicHeight(
          child: Row(
            children: [
              if (isCancelledOrMissed)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: VerticalDivider(
                    color: AppColors.orangeDark,
                    width: 2.0,
                    thickness: 2.0,
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isHappeningNow && !isCancelledOrMissed)
                    Text(
                      '${startDate.weekdayString} ' +
                          '${LocalizedTexts.from.translation} ${startDate.timeHoursMinutes24} ' +
                          '${LocalizedTexts.to.translation} ${endDate.timeHoursMinutes24}.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  if (!isHappeningNow)
                    Text(
                      '${LocalizedTexts.booked.translation} ${startDate.weekdayString} ' +
                          '${LocalizedTexts.from.translation} ${startDate.timeHoursMinutes24} ' +
                          '${LocalizedTexts.to.translation} ${endDate.timeHoursMinutes24}.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.greyLabel),
                    ),
                  if (isCancelledOrMissed)
                    Row(
                      children: [
                        const Image(image: AppIcons.exclamationPoint, width: 16, height: 16),
                        const SizedBox(width: 8.0),
                        if (isCancelled)
                          Text(LocalizedTexts.timeslotCancelled.translation,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: AppColors.orangeDark))
                              .tr(),
                        if (!isCancelled && isMissed)
                          Text(LocalizedTexts.timeslotMissed.translation,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: AppColors.orangeDark))
                              .tr(),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        if (isCancelledOrMissed) GroupedSignedCancelledBooking(isTimeslotsAvailable: timeSlotsAvailable),
        if (preparationMaterialsAvailable) const PreparationMaterials(),
        if (!isCancelled && sessionMightBeCancelled)
          GroupedSignedMightBeCancelled(number: signedGroupSessions.minMemberCount),
      ],
    );
  }

  _onMoreInfoPressed(BuildContext context) {
    ModalBottomSheet.sessionMoreInfoDialog(context: context);
  }
}
