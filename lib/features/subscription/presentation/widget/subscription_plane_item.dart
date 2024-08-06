import 'package:badges/badges.dart' as badge;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class SubscriptionPlane extends SubscriptionPlaneItem {
  const SubscriptionPlane.general({
    required super.title,
    required super.description,
    super.recommended,
    super.offer,
    super.regularPrice,
    required super.priceWithCurrency,
    required super.selected,
    super.onTap,
    super.key,
  });
}

class SubscriptionPlaneItem extends StatelessWidget {
  final String title;
  final String description;
  final String? offer;
  final String? regularPrice;
  final String priceWithCurrency;
  final Function()? onTap;
  final bool selected;
  final bool recommended;

  const SubscriptionPlaneItem({
    super.key,
    required this.title,
    required this.description,
    required this.selected,
    this.offer,
    this.regularPrice,
    required this.priceWithCurrency,
    this.onTap,
    this.recommended = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: _BadgeWrapper(
        recommended: recommended,
        child: InkWell(
          onTap: onTap,
          highlightColor: AppColors.blueLighter,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          child: Card(
            color: selected ? AppColors.blueLighter : AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomText.bitter600(
                      //Todo remove priceWithCurrency will be updated with localization
                      LocalizedTexts.subscriptionTitlePrice.tr(
                        args: [title, ''],
                      ),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.blueDarkest,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (description.contains('('))
                      _DescriptionWrapper(description: description)
                    else
                      CustomText.w400(
                        description,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.coralRegular,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BadgeWrapper extends StatelessWidget {
  final Widget child;
  final bool recommended;

  const _BadgeWrapper({required this.child, this.recommended = false});

  @override
  Widget build(BuildContext context) {
    if (recommended) {
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
        badgeContent: CustomText.w600(
          LocalizedTexts.recommended.tr().toUpperCase(),
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: ThemeConstants.fontSize10,
            color: AppColors.blueDarker,
          ),
        ),
        child: child,
      );
    } else {
      return child;
    }
  }
}

class _DescriptionWrapper extends StatelessWidget {
  final String description;

  const _DescriptionWrapper({required this.description});

  String _getDescription() {
    final startIndex = description.indexOf('(');
    return description.substring(0, startIndex);
  }

  String _getDescriptionTile() {
    final startIndex = description.indexOf('(');
    final endIndex = description.indexOf(')');
    return description.substring(startIndex, endIndex + 1);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: _getDescription(),
            style: context.textTheme.bodyMedium?.copyWith(
              fontFamily: ThemeConstants.bitterFontFamily,
              color: AppColors.blueDarkest,
              fontWeight: FontWeight.w400,
            ),
          ),
          const WidgetSpan(
            child: SizedBox(
              height: 1.0,
            ),
          ),
          TextSpan(
            text: _getDescriptionTile(),
            style: context.textTheme.bodyMedium?.copyWith(
              fontFamily: ThemeConstants.bitterFontFamily,
              color: AppColors.coralRegular,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
