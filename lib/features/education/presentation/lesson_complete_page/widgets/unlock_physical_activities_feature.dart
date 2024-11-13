import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/feature_unlock.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class UnlockPhysicalActivitiesFeature extends StatelessWidget {
  const UnlockPhysicalActivitiesFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureUnlock(
      title: LocalizedTexts.physicalActivitiesUnlockedTitle.tr(),
      body: LocalizedTexts.physicalActivitiesUnlockedText.tr(),
    );
  }
}
