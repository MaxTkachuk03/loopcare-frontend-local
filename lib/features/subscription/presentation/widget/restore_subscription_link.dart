import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class RestoreSubscriptionLink extends StatelessWidget {
  final Function onTap;

  const RestoreSubscriptionLink({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () => _navigate(context, isTerms: false),
            text: LocalizedTexts.subscriptionRestoreLabel.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: ThemeConstants.fontSize14,
                  fontFamily: ThemeConstants.openSansFontFamily,
                  color: AppColors.blueLink,
                  fontWeight: FontWeight.w400,
                ),
          ),
          TextSpan(
            text: '-',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: ThemeConstants.fontSize14,
                  fontFamily: ThemeConstants.openSansFontFamily,
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w400,
                ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () => _navigate(context, isTerms: true),
            text: LocalizedTexts.subscriptionTermsLabel.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: ThemeConstants.fontSize14,
                  fontFamily: ThemeConstants.openSansFontFamily,
                  color: AppColors.blueLink,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, {required bool isTerms}) {
    // WebViewScreenRoute(
    //   url: url,
    //   title: title,
    // ).show(context);
  }
}
