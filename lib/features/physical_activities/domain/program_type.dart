import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

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
}
