import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/feature_unlock.dart';

class UnlockFoodLoggingFeature extends StatelessWidget {
  final VoidCallback? onBtnPressed;
  final bool showFoodPreferencesBtn;
  const UnlockFoodLoggingFeature({
    super.key,
    required this.onBtnPressed,
    required this.showFoodPreferencesBtn,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureUnlock(
      title: LocalizedTexts.foodLoggingUnlocked.tr(),
      body: LocalizedTexts.youCanStartLogging.tr(),
      action: (showFoodPreferencesBtn)
          ? CustomOutlinedButton.blueSmall(
              onPressed: onBtnPressed,
              label: LocalizedTexts.startNow.tr(),
            )
          : null,
    );
  }
}
