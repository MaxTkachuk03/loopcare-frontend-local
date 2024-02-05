import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/feature_unlock.dart';

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
