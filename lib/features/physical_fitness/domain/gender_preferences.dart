import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

enum GenderPreferences {
  noPreference,
  femaleOnly,
  maleOnly,
  mixed,
}

extension GenderPreferencesX on GenderPreferences {
  String get label {
    switch (this) {
      case GenderPreferences.noPreference:
        return LocalizedTexts.noPreference.tr().capitalize();
      case GenderPreferences.femaleOnly:
        return LocalizedTexts.femaleOnly.tr().capitalize();
      case GenderPreferences.maleOnly:
        return LocalizedTexts.maleOnly.tr().capitalize();
      case GenderPreferences.mixed:
        return LocalizedTexts.mixed.tr().capitalize();
    }
  }
}
