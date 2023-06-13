import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum ProgramLocation {
  home,
  office,
  outdoor,
}

extension ProgramLocationX on ProgramLocation {
  String get label {
    switch (this) {
      case ProgramLocation.home:
        return LocalizedTexts.home.translation;
      case ProgramLocation.office:
        return LocalizedTexts.office.translation;
      case ProgramLocation.outdoor:
        return LocalizedTexts.outdoor.translation;
    }
  }
}
