import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum ProgramPlace {
  home,
  office,
  outdoor,
}

extension ProgramPlaceX on ProgramPlace {
  String get label {
    switch (this) {
      case ProgramPlace.home:
        return LocalizedTexts.home.translation;
      case ProgramPlace.office:
        return LocalizedTexts.office.translation;
      case ProgramPlace.outdoor:
        return LocalizedTexts.outdoor.translation;
    }
  }

  bool get isAvailable {
    switch (this) {
      case ProgramPlace.home:
        return false;
      case ProgramPlace.office:
        return true;
      case ProgramPlace.outdoor:
        return true;
    }
  }
}
