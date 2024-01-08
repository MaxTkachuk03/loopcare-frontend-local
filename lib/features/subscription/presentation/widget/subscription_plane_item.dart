import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class SubscriptionPlane extends SubscriptionPlaneItem {
  const SubscriptionPlane.general({
    required super.title,
    super.offer,
    super.regularPrice,
    super.currency,
    required super.selected,
    super.onTap,
    super.key,
  });
}

class SubscriptionPlaneItem extends StatelessWidget {
  final String title;
  final String? offer;
  final String? regularPrice;
  final String? currency;
  final Function()? onTap;
  final bool selected;

  const SubscriptionPlaneItem({
    super.key,
    required this.title,
    required this.selected,
    this.offer,
    this.regularPrice,
    this.currency,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                CustomText.w600(
                  title.tr(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.blueDarkest,
                  ),
                ),
                if (regularPrice != null && currency != null)
                  CustomText.w400(
                    LocalizedTexts.subscriptionPrice
                        .tr()
                        .replaceAll('{C}', currency!)
                        .replaceAll('{XX,XX}', regularPrice!),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.blueDarkest,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
