// import 'package:flutter/material.dart';
// import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
// import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/session_card.dart';

// class GroupedSigned extends StatelessWidget {
//   final String topicName;
//   final DateTime startDate;
//   final DateTime endDate;
//   final bool preparationMaterialsAvailable;
//   final bool isCancelledOrMissed;
//   final bool isCancelled;
//   final bool isMissed;
//   final bool timeSlotsAvailable;
//   final bool sessionMightBeCancelled;
//   final bool isHappeningNow;
//   final bool isCanJoin;
//   final int minMemberCount;
//   // final String image;

//   const GroupedSigned({
//     super.key,
//     required this.topicName,
//     required this.startDate,
//     required this.endDate,
//     required this.preparationMaterialsAvailable,
//     required this.isCancelledOrMissed,
//     required this.isCancelled,
//     required this.isMissed,
//     required this.timeSlotsAvailable,
//     required this.sessionMightBeCancelled,
//     required this.isHappeningNow,
//     required this.isCanJoin,
//     required this.minMemberCount,
//     // required this.image,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SessionCard(
//       topicName: topicName,
//       startDate: startDate,
//       endDate: endDate,
//       preparationMaterialsAvailable: preparationMaterialsAvailable,
//       isCancelledOrMissed: isCancelledOrMissed,
//       isCancelled: isCancelled,
//       isMissed: isMissed,
//       timeSlotsAvailable: timeSlotsAvailable,
//       sessionMightBeCancelled: sessionMightBeCancelled,
//       isHappeningNow: isHappeningNow,
//       isCanJoin: isCanJoin,
//       minMemberCount: minMemberCount,
//       // image: image,
//     );

//     // Column(
//     //   crossAxisAlignment: CrossAxisAlignment.start,
//     //   children: [
//     //     InkWell(
//     //       onTap: () => _onMoreInfoPressed(context),
//     //       child: Row(
//     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //         children: [
//     //           Flexible(
//     //             child: Text(
//     //               topicName,
//     //               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//     //                     fontWeight: FontWeight.w600,
//     //                   ),
//     //             ),
//     //           ),
//     //           const ImageIcon(AppIcons.arrow, color: AppColors.greyLabel),
//     //         ],
//     //       ),
//     //     ),
//     //     const SizedBox(height: 8.0),
//     //     IntrinsicHeight(
//     //       child: Row(
//     //         children: [
//     //           if (isCancelledOrMissed)
//     //             const Padding(
//     //               padding: EdgeInsets.only(right: 8.0),
//     //               child: VerticalDivider(
//     //                 color: AppColors.orangeDark,
//     //                 width: 2.0,
//     //                 thickness: 2.0,
//     //               ),
//     //             ),
//     //           Column(
//     //             crossAxisAlignment: CrossAxisAlignment.start,
//     //             children: [
//     //               if (isHappeningNow && !isCancelledOrMissed)
//     //                 Text(
//     //                   LocalizedTexts.dayFromTo,
//     //                   style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.greyLabel),
//     //                 ).tr(
//     //                   namedArgs: {
//     //                     'day': startDate.weekdayString,
//     //                     'startTime': startDate.timeHoursMinutes24,
//     //                     'endTime': endDate.timeHoursMinutes24,
//     //                   },
//     //                 ),
//     //               if (!isHappeningNow)
//     //                 Text(
//     //                   LocalizedTexts.bookedFromTo,
//     //                   style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.greyLabel),
//     //                 ).tr(
//     //                   namedArgs: {
//     //                     'day': startDate.weekdayString,
//     //                     'startTime': startDate.timeHoursMinutes24,
//     //                     'endTime': endDate.timeHoursMinutes24,
//     //                   },
//     //                 ),
//     //               if (isCancelledOrMissed)
//     //                 Row(
//     //                   children: [
//     //                     const Image(image: AppIcons.exclamationPoint, width: 16, height: 16),
//     //                     const SizedBox(width: 8.0),
//     //                     if (isCancelled)
//     //                       Text(LocalizedTexts.timeslotCancelled.translation,
//     //                               style: Theme.of(context)
//     //                                   .textTheme
//     //                                   .bodySmall
//     //                                   ?.copyWith(color: AppColors.orangeDark))
//     //                           .tr(),
//     //                     if (!isCancelled && isMissed)
//     //                       Text(LocalizedTexts.timeslotMissed.translation,
//     //                               style: Theme.of(context)
//     //                                   .textTheme
//     //                                   .bodySmall
//     //                                   ?.copyWith(color: AppColors.orangeDark))
//     //                           .tr(),
//     //                   ],
//     //                 ),
//     //             ],
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //     const SizedBox(height: 8.0),
//     //     if (isCancelledOrMissed) GroupedSignedCancelledBooking(isTimeslotsAvailable: timeSlotsAvailable),
//     //     if (preparationMaterialsAvailable) const PreparationMaterials(),
//     //     if (isCanJoin && !isCancelledOrMissed) const GroupedJoinSession(),
//     //     if (!isCancelled && sessionMightBeCancelled)
//     //       GroupedSignedMightBeCancelled(number: signedGroupSessions.minMemberCount),
//     //   ],
//     // );
//   }

//   _onMoreInfoPressed(BuildContext context) {
//     ModalBottomSheet.sessionsDialog(context: context);
//   }
// }
