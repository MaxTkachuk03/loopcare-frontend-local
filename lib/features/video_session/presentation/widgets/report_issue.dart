import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

class ReportIssue extends StatelessWidget {
  final Function()? onReportIssueHandler;

  const ReportIssue({super.key, this.onReportIssueHandler});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomOutlinedButton.blueSmall(
            onPressed: onReportIssueHandler,
            label: LocalizedTexts.reportIssue.tr(),
          )
        ],
      ),
    );
  }
}
