import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class RestoreSubscriptionLink extends StatelessWidget {
  final Function onRestoreTap;

  const RestoreSubscriptionLink({super.key, required this.onRestoreTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () => _navigate(context, isTerms: false),
            text: LocalizedTexts.subscriptionRestoreLabel.tr(),
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: ThemeConstants.fontSize14,
              fontFamily: ThemeConstants.openSansFontFamily,
              color: AppColors.blueDarker,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w700,
            ),
          ),
          const WidgetSpan(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () => _navigate(context, isTerms: true),
            text: LocalizedTexts.subscriptionTermsLabel.tr(),
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: ThemeConstants.fontSize14,
              fontFamily: ThemeConstants.openSansFontFamily,
              color: AppColors.blueDarker,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, {required bool isTerms}) {
    if (!isTerms) {
      onRestoreTap();
    }
    // WebViewScreenRoute(
    //   url: url,
    //   title: title,
    // ).show(context);
  }
}
