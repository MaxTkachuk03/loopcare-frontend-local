import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SubscriptionPlane extends SubscriptionPlaneItem {
  const SubscriptionPlane.annual(
      {String? monthlyPrice, String? commonPrice, String? currency, required bool selected, Function()? onTap, super.key})
      : super(
          title: LocalizedTexts.subscriptionAnnual,
          monthlyPrice: monthlyPrice,
          commonPrice: commonPrice,
          currency: currency,
          selected: selected,
          onTap: onTap,
        );

  const SubscriptionPlane.monthly(
      {String? monthlyPrice, String? commonPrice, String? currency, Function()? onTap, required bool selected, super.key})
      : super(
          title: LocalizedTexts.subscriptionMonthly,
          monthlyPrice: monthlyPrice,
          commonPrice: commonPrice,
          currency: currency,
          selected: selected,
          onTap: onTap,
        );
}

class SubscriptionPlaneItem extends StatelessWidget {
  final String title;
  final String? monthlyPrice;
  final String? commonPrice;
  final String? currency;
  final Function()? onTap;
  final bool selected;

  const SubscriptionPlaneItem({
    super.key,
    required this.title,
    required this.selected,
    this.monthlyPrice,
    this.commonPrice,
    this.currency,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  onTap,
      highlightColor: AppColors.greenLight.withOpacity(0.5),
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        height: 80,
        child: Card(
          color: selected ? AppColors.greenLight.withOpacity(0.5) : AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: ThemeConstants.fontSize16,
                        fontFamily: ThemeConstants.openSansFontFamily,
                        color: AppColors.darkGreen,
                        fontWeight: FontWeight.w700,
                      ),
                ).tr(),
                if (commonPrice != null && monthlyPrice != null && currency != null)
                  Text(
                      LocalizedTexts.subscriptionPrice
                          .tr()
                          .replaceAll('{C}', currency!)
                          .replaceAll('{XX,XX}', commonPrice!)
                          .replaceAll('{X,XX}', monthlyPrice!),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: ThemeConstants.fontSize16,
                            fontFamily: ThemeConstants.openSansFontFamily,
                            color: AppColors.darkGreen,
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
