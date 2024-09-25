import 'dart:math' as math;

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_image.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

//Todo will implemented according new requirements in future
class MultiplePlanItem extends StatelessWidget {
  const MultiplePlanItem({
    super.key,
    required this.showBadge,
    required this.onTap,
    required this.selected,
    required this.title,
    required this.priceWithCurrency,
    required this.description,
  });

  final bool? showBadge;
  final Function()? onTap;
  final bool selected;
  final String title;
  final String priceWithCurrency;
  final String description;

  @override
  Widget build(BuildContext context) {
    return _BadgeWrapper(
      showBadge: showBadge ?? false,
      child: InkWell(
        highlightColor: AppColors.blueLighter,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        child: Card(
          elevation: 0,
          child: ListTile(
            selected: selected,
            selectedColor: AppColors.blueLighter,
            onTap: onTap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: EdgeInsets.zero,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText.bitter600(
                    title,
                    style: context.textTheme.displayLarge?.copyWith(color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                  CustomText.w400(
                    LocalizedTexts.subscriptionDescriptionLabel.tr(),
                    style:
                        context.textTheme.bodySmall?.copyWith(fontSize: ThemeConstants.fontSize12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SinglePlanItem extends StatelessWidget {
  const SinglePlanItem({
    super.key,
    this.isPricedOffer = false,
    this.badgeUrl,
    required this.title,
    required this.titleColor,
  });

  final bool isPricedOffer;
  final String title;
  final Color titleColor;
  final String? badgeUrl;

  @override
  Widget build(BuildContext context) {
    if (isPricedOffer) {
      return _PricedOfferItem(title: title, url: badgeUrl, titleColor: titleColor);
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText.bitter600(
            title,
            style: context.textTheme.displayLarge?.copyWith(color: titleColor),
            textAlign: TextAlign.center,
          ),
          CustomText.w400(
            LocalizedTexts.subscriptionDescriptionLabel.tr(),
            style: context.textTheme.bodySmall
                ?.copyWith(fontSize: ThemeConstants.fontSize12, color: titleColor),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }
}

class _PricedOfferItem extends StatelessWidget {
  final String title;
  final String? url;
  final Color titleColor;

  const _PricedOfferItem({
    required this.url,
    required this.title,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomText.bitter600(
                      title,
                      style: context.textTheme.displayLarge?.copyWith(color: titleColor),
                      textAlign: TextAlign.center,
                    ),
                    AppImages.subscriptionCross,
                  ],
                ),
                CustomText.w400(
                  LocalizedTexts.subscriptionDescriptionLabel.tr(),
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontSize: ThemeConstants.fontSize12, color: titleColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Transform.rotate(
              angle: math.pi / 12.0,
              child: SubscriptionImage(url: url),
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeWrapper extends StatelessWidget {
  final Widget child;
  final bool showBadge;

  const _BadgeWrapper({
    required this.child,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    if (showBadge) {
      return badge.Badge(
        badgeStyle: const badge.BadgeStyle(
          badgeColor: AppColors.coralRegular,
          shape: badge.BadgeShape.square,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          padding: EdgeInsets.all(2.0),
        ),
        badgeAnimation: const badge.BadgeAnimation.slide(toAnimate: false),
        position: badge.BadgePosition.topEnd(
          top: -4,
        ),
        child: child,
      );
    } else {
      return child;
    }
  }
}
