import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

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
          Text(
            '${LocalizedTexts.discussion.tr()}: $minutesLeft ${LocalizedTexts.minutes.tr()} ${LocalizedTexts.left.tr()}',
            style: const TextStyle(
              color: AppColors.darkGreen,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              side: const BorderSide(width: 1.0, color: AppColors.yellowLight),
              minimumSize: const Size(0, 32.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            ),
            onPressed: onReportIssueHandler,
            child: const Text(
              LocalizedTexts.reportIssue,
              style: TextStyle(
                color: AppColors.darkGreen,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ).tr(),
          )
        ],
      ),
    );
  }
}
