import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/subscription/presentation/controller/subscription_controller.dart';

class SubscribeButton extends StatelessWidget {
  final SubscriptionController controller;

  const SubscribeButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.isEnableSubscribe,
      builder: (context, isEnableSubscribe, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: controller.loading,
          builder: (context, loading, _) {
            return ValueListenableBuilder<String>(
                valueListenable: controller.subscribeTitle,
                builder: (context, title, _) {
                  return CustomElevatedButton.coralFullWidth(
                      isLoading: loading,
                      onPressed: isEnableSubscribe ? controller.onSubscribe : null,
                      label: title);
                });
          },
        );
      },
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
      child:
          CustomElevatedButton.coral(onPressed: onTap, label: LocalizedTexts.ok.tr().toUpperCase()),
    );
  }
}
