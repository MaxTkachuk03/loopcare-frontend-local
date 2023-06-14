import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum ProgramDifficulty {
  easy,
  medium,
  hard,
}

extension ProgramDifficultyX on ProgramDifficulty {
  String get label {
    switch (this) {
      case ProgramDifficulty.easy:
        return LocalizedTexts.easy.translation;
      case ProgramDifficulty.medium:
        return LocalizedTexts.medium.translation;
      case ProgramDifficulty.hard:
        return LocalizedTexts.hard.translation;
    }
  }
}
