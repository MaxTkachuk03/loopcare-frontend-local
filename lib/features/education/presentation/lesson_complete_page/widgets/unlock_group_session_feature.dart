import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/feature_unlock.dart';
import 'package:loopcare_frontend/injection.dart';

class UnlockGroupSessionFeature extends StatelessWidget {
  const UnlockGroupSessionFeature({super.key});

  String get _bodyText {
    final account = getIt<SharedStorageService>().account!;
    final isTreatedByPsychiatrist = account.medicalOnboarding!.treatedByPsychiatrist;

    if (account.isOnTrial) {
      return LocalizedTexts.trialSubscriptionLessonComplete;
    } else if (isTreatedByPsychiatrist) {
      return LocalizedTexts.treatedByTherapistLessonComplete;
    } else {
      return LocalizedTexts.unlockFeatureDescription;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FeatureUnlock(title: LocalizedTexts.groupSessionsUnlocked.tr(), body: _bodyText.tr());
  }
}
