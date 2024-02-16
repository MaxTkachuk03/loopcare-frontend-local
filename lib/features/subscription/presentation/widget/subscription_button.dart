import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_controller.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_service.dart';
import 'package:loopcare_frontend/injection.dart';

class SubscribeButton extends StatelessWidget {
  final SubscriptionController controller;

  const SubscribeButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final AppSubscriptionService inAppPurchaseService = getIt<AppSubscriptionService>();

    return Column(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: controller.isEnableSubscribe,
          builder: (context, isEnableSubscribe, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: CustomElevatedButton.blueFullWidth(
                  onPressed: isEnableSubscribe ? controller.onSubscribe : null,
                  label: LocalizedTexts.subscriptionSubscribe),
            );
          },
        ),
        if (Platform.isIOS)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: CustomElevatedButton.blueFullWidth(
                onPressed: () => inAppPurchaseService.instance
                    .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>()
                    .presentCodeRedemptionSheet(),
                label: LocalizedTexts.subscriptionRedeem),
          ),
      ],
    );
  }
}

class RenewButton extends StatelessWidget {
  final Function()? onTap;

  const RenewButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: CustomElevatedButton.blueFullWidth(onPressed: onTap, label: LocalizedTexts.ok.tr().toUpperCase()),
    );
  }
}
