import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/feature_unlock.dart';

class UnlockBuddyFeature extends StatelessWidget {
  const UnlockBuddyFeature({super.key});

  void _onPressedHandler(BuildContext context) => context.router.pushNamed(AppRoutes.buddyPreferences);

  @override
  Widget build(BuildContext context) {
    return FeatureUnlock(
      title: LocalizedTexts.buddyUnlocked.tr(),
      body: LocalizedTexts.buddyUnlockedBody.tr(),
      action: CustomOutlinedButton.blueSmall(
        onPressed: () => _onPressedHandler(context),
        label: LocalizedTexts.goToBuddyPreferences.tr(),
      ),
    );
  }
}
