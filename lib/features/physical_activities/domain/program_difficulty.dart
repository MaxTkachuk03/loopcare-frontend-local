import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum ProgramDifficulty {
  easy,
  medium,
  hard,
}

extension ProgramDifficultyX on ProgramDifficulty {
  String get label {
    switch (this) {
      case ProgramDifficulty.easy:
        return LocalizedTexts.easy.tr();
      case ProgramDifficulty.medium:
        return LocalizedTexts.medium.tr();
      case ProgramDifficulty.hard:
        return LocalizedTexts.hard.tr();
    }
  }

  bool get isAvailable {
    switch (this) {
      case ProgramDifficulty.easy:
        return true;
      case ProgramDifficulty.medium:
        return true;
      case ProgramDifficulty.hard:
        return true;
    }
  }
}
