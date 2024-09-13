import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

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
