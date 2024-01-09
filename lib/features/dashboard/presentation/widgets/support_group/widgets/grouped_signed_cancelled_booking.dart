// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
// import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
// import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
// import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

// class GroupedSignedCancelledBooking extends StatelessWidget {
//   final bool isTimeslotsAvailable;

//   const GroupedSignedCancelledBooking({
//     super.key,
//     required this.isTimeslotsAvailable,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return isTimeslotsAvailable
//         ? InkWell(
//             onTap: () => _onBookSeatPressed(context),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//               decoration: BoxDecoration(
//                 color: AppColors.blueDark,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     LocalizedTexts.chooseAnotherTimeslot,
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                           color: AppColors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ).tr(),
//                   const ImageIcon(
//                     AppIcons.arrow,
//                     color: AppColors.white,
//                   ),
//                 ],
//               ),
//             ),
//           )
//         : Text(
//             LocalizedTexts.noTimeslotsOnthisWeek,
//             style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.darkGreen),
//           ).tr();
//   }

//   _onBookSeatPressed(BuildContext context) {
//     ModalBottomSheet.sessionsDialog(context: context);
//   }
// }
