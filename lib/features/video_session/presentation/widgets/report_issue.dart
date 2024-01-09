import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

class ReportIssue extends StatelessWidget {
  final int minutesLeft;
  final Function()? onReportIssueHandler;

  const ReportIssue({super.key, required this.minutesLeft, this.onReportIssueHandler});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          // TODO will be implemented in future
          // Text(
          //   '${LocalizedTexts.discussion.tr()}: $minutesLeft ${LocalizedTexts.minutes.tr()} ${LocalizedTexts.left.tr()}',
          //   style: const TextStyle(
          //     color: AppColors.darkGreen,
          //     fontSize: 12.0,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          CustomOutlinedButton.blueSmall(
            onPressed: onReportIssueHandler,
            label: LocalizedTexts.reportIssue.tr(),
          )
        ],
      ),
    );
  }
}
