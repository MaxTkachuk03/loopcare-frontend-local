import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum ProgramType {
  strength,
  endurance,
  mobility,
}

extension ProgramTypeX on ProgramType {
  String get label {
    switch (this) {
      case ProgramType.strength:
        return LocalizedTexts.strength.translation;
      case ProgramType.endurance:
        return LocalizedTexts.endurance.translation;
      case ProgramType.mobility:
        return LocalizedTexts.mobility.translation;
    }
  }
}
