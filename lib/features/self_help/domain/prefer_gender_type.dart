import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

enum PreferGenderType {
  onlyFemale,
  onlyMale,
  no,
}

extension PreferGenderTypeX on PreferGenderType {
  String get label {
    switch (this) {
      case PreferGenderType.onlyFemale:
        return LocalizedTexts.selfHelpGenderPreferencesYesFemale
            .tr()
            .capitalize();
      case PreferGenderType.onlyMale:
        return LocalizedTexts.selfHelpGenderPreferencesYesMale
            .tr()
            .capitalize();
      case PreferGenderType.no:
        return LocalizedTexts.selfHelpGenderPreferencesNo.tr().capitalize();
    }
  }
}
