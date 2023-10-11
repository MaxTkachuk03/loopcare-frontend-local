import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_controller.dart';

class SubscribeButton extends StatelessWidget {
  final SubscriptionController controller;

  const SubscribeButton({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.isEnableSubscribe,
      builder: (context, isEnableSubscribe, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: isEnableSubscribe ? controller.onSubscribe : null,
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  backgroundColor: isEnableSubscribe
                      ? MaterialStateProperty.all(AppColors.orangeDark)
                      : MaterialStateProperty.all(AppColors.greyLight),
                ),
            child: Text(
              LocalizedTexts.subscriptionSubscribe,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: ThemeConstants.fontSize16,
                    fontFamily: ThemeConstants.openSansFontFamily,
                    fontWeight: FontWeight.w600,
                    color: isEnableSubscribe ? AppColors.white : AppColors.datePickerBg,
                  ),
            ).tr(),
          ),
        );
      },
    );
  }
}

class RenewButton extends StatelessWidget {
  final Function()? onTap;

  const RenewButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: Theme.of(context)
          .elevatedButtonTheme
          .style
          ?.copyWith(backgroundColor: MaterialStateProperty.all(AppColors.orangeDark)),
      child: Text(
        LocalizedTexts.ok.toUpperCase(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: ThemeConstants.fontSize16,
              fontFamily: ThemeConstants.openSansFontFamily,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
      ).tr(),
    );
  }
}
