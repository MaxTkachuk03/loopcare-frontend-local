import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

//Todo commented according MMP design, will be improved further
enum ProgramType {
  strength,
  endurance,
  mobility,
}

extension ProgramTypeX on ProgramType {
  String get label {
    switch (this) {
      case ProgramType.strength:
        return LocalizedTexts.strength.tr().capitalize();
      case ProgramType.endurance:
        return LocalizedTexts.endurance.tr().capitalize();
      case ProgramType.mobility:
        return LocalizedTexts.mobility.tr().capitalize();
    }
  }

  String get title {
    switch (this) {
      case ProgramType.strength:
        return LocalizedTexts.strengthPrograms.tr();
      case ProgramType.endurance:
        return LocalizedTexts.endurance.tr();
      case ProgramType.mobility:
        return LocalizedTexts.mobility.tr();
    }
  }

  bool get isAvailable {
    switch (this) {
      case ProgramType.strength:
        return true;
      case ProgramType.endurance:
        return false;
      case ProgramType.mobility:
        return false;
    }
  }
}
