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
        return LocalizedTexts.strength.translation.capitalize();
      case ProgramType.endurance:
        return LocalizedTexts.endurance.translation.capitalize();
      case ProgramType.mobility:
        return LocalizedTexts.mobility.translation.capitalize();
    }
  }

  String get title {
    switch (this) {
      case ProgramType.strength:
        return LocalizedTexts.strengthPrograms.translation;
      case ProgramType.endurance:
        return LocalizedTexts.endurance.translation;
      case ProgramType.mobility:
        return LocalizedTexts.mobility.translation;
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
