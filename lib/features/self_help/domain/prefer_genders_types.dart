import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

enum PreferGendersTypes {
  onlyFemale,
  onlyMale,
  no,
}

extension PreferGendersTypesX on PreferGendersTypes {
  String get label {
    switch (this) {
      case PreferGendersTypes.onlyFemale:
        return LocalizedTexts.selfHelpGenderPreferencesYesFemale
            .tr()
            .capitalize();
      case PreferGendersTypes.onlyMale:
        return LocalizedTexts.selfHelpGenderPreferencesYesMale
            .tr()
            .capitalize();
      case PreferGendersTypes.no:
        return LocalizedTexts.selfHelpGenderPreferencesNo.tr().capitalize();
    }
  }
}
