import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum ProgramType {
  strength,
  endurance,
  mobility;

  String get label => switch (this) {
        strength => LocalizedTexts.strength.tr().capitalize(),
        endurance => LocalizedTexts.endurance.tr().capitalize(),
        mobility => LocalizedTexts.mobility.tr().capitalize(),
      };

  String get title => switch (this) {
        strength => LocalizedTexts.strengthPrograms.tr(),
        endurance => LocalizedTexts.endurance.tr(),
        mobility => LocalizedTexts.mobility.tr(),
      };

  bool get isAvailable => this == ProgramType.strength;
}
