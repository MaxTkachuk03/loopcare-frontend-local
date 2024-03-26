import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class SubscriptionHeaderTitle extends StatelessWidget {
  final String title;

  const SubscriptionHeaderTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomText.bitter600(
        title.tr(),
        textAlign: TextAlign.center,
        style: context.textTheme.displayLarge?.copyWith(color: AppColors.white),
      ),
    );
  }
}

class SubscriptionHeaderLabel extends StatelessWidget {
  final String label;
  final String? subTitle;

  const SubscriptionHeaderLabel({super.key, required this.label, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          if (subTitle != null)
            CustomText(
              subTitle!.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          SizedBox(height: subTitle != null ? 27 : 16.0),
          CustomText(
            label.tr(),
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class SubscriptionTitle extends SubscriptionHeaderTitle {
 const SubscriptionTitle.trial({super.key})
      : super(
          title: LocalizedTexts.subscriptionTrialTitle,
        );

  const SubscriptionTitle.trialExpired({super.key})
      : super(
          title: LocalizedTexts.subscriptionTrialExpiredTitle,
        );

  const SubscriptionTitle.endedSubscription({super.key})
      : super(
          title: LocalizedTexts.subscriptionEndedTitle,
        );

  const SubscriptionTitle.cancelledSubscription({super.key})
      : super(
          title: LocalizedTexts.subscriptionCancelledTitle,
        );

  const SubscriptionTitle.notRenewSubscription({super.key})
      : super(
          title: LocalizedTexts.subscriptionRenewedTitle,
        );

  const SubscriptionTitle.serviceUnavailable({super.key})
      : super(
          title: LocalizedTexts.serviceUnavailable,
        );
}

class SubscriptionLabel extends SubscriptionHeaderLabel {
  const SubscriptionLabel.trial({super.key})
      : super(
          label: LocalizedTexts.subscriptionTrialLabel,
        );

  const SubscriptionLabel.trialExpired({super.key})
      : super(
          subTitle: LocalizedTexts.subscriptionTrialExpiredLabel1,
          label: LocalizedTexts.subscriptionTrialExpiredLabel2,
        );

  const SubscriptionLabel.endedSubscription({super.key})
      : super(
          subTitle: LocalizedTexts.subscriptionEndedLabel1,
          label: LocalizedTexts.subscriptionEndedLabel2,
        );

  const SubscriptionLabel.cancelledSubscription({super.key})
      : super(
          subTitle: LocalizedTexts.subscriptionCancelledLabel1,
          label: LocalizedTexts.subscriptionCancelledLabel2,
        );

  const SubscriptionLabel.notRenewSubscription({super.key})
      : super(
          label: LocalizedTexts.subscriptionRenewedLabel,
        );

  const SubscriptionLabel.serviceUnavailable({super.key})
      : super(
          label: '',
        );
}
