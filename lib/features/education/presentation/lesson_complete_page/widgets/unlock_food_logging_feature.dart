import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/feature_unlock.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

// todo: check if this is still needed
class UnlockFoodLoggingFeature extends StatelessWidget {
  const UnlockFoodLoggingFeature({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureUnlock(
      title: LocalizedTexts.foodLoggingUnlocked.tr(),
      body: LocalizedTexts.youCanStartLogging.tr(),
    );
  }
}
