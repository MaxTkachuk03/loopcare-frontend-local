import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class RestoreSubscriptionLink extends StatelessWidget {
  final Function onRestoreTap;

  const RestoreSubscriptionLink({super.key, required this.onRestoreTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <InlineSpan>[
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0),
                ),
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => onRestoreTap(),
                text: LocalizedTexts.subscriptionRestoreLabel.tr(),
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: ThemeConstants.fontSize14,
                  fontFamily: ThemeConstants.openSansFontFamily,
                  color: AppColors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                ),
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launchUrl(Uri.parse(privacyPolicyUrl), mode: LaunchMode.externalApplication),
                text: LocalizedTexts.subscriptionPrivacyLabel.tr(),
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: ThemeConstants.fontSize14,
                  fontFamily: ThemeConstants.openSansFontFamily,
                  color: AppColors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launchUrl(Uri.parse(termsAndConditionsUrl), mode: LaunchMode.externalApplication),
                text: LocalizedTexts.subscriptionTermsLabel.tr(),
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: ThemeConstants.fontSize14,
                  fontFamily: ThemeConstants.openSansFontFamily,
                  color: AppColors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
