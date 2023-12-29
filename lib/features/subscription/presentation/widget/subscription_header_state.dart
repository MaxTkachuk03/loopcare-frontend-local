import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/report_abuse/presentation/widget/report_section_title.dart';

enum SubscriptionTypeState { trial, expiredTrial, endedSubscription, cancelledSubscription, notRenewSubscription }

class SubscriptionHeaderState extends StatelessWidget {
  final String title;
  final String label;

  const SubscriptionHeaderState({super.key, required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ReportSectionTitle(
              title: title,
              style: context.textTheme.displayLarge,
              textAlign: TextAlign.center,
              color: AppColors.darkGreen,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: ThemeConstants.fontSize16,
              fontFamily: ThemeConstants.openSansFontFamily,
              color: AppColors.darkGreen,
              fontWeight: FontWeight.w400,
            ),
          ).tr(),
        ],
      ),
    );
  }
}

class SubscriptionHeader extends SubscriptionHeaderState {
  const SubscriptionHeader.trial({super.key})
      : super(
          title: LocalizedTexts.subscriptionTrialTitle,
          label: LocalizedTexts.subscriptionTrialLabel,
        );

  const SubscriptionHeader.trialExpired({super.key})
      : super(
          title: LocalizedTexts.subscriptionTrialExpiredTitle,
          label: LocalizedTexts.subscriptionTrialExpiredLabel,
        );

  const SubscriptionHeader.endedSubscription({super.key})
      : super(
          title: LocalizedTexts.subscriptionEndedTitle,
          label: LocalizedTexts.subscriptionEndedLabel,
        );

  const SubscriptionHeader.cancelledSubscription({super.key})
      : super(
          title: LocalizedTexts.subscriptionCancelledTitle,
          label: LocalizedTexts.subscriptionCancelledLabel,
        );

  const SubscriptionHeader.notRenewSubscription({super.key})
      : super(
          title: LocalizedTexts.subscriptionRenewedTitle,
          label: LocalizedTexts.subscriptionRenewedLabel,
        );

  const SubscriptionHeader.serviceUnavailable({super.key})
      : super(
          title: LocalizedTexts.serviceUnavailable,
          label: '',
        );
}
