import 'package:easy_localization/easy_localization.dart';
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
        return LocalizedTexts.home.tr();
      case ProgramPlace.office:
        return LocalizedTexts.office.tr();
      case ProgramPlace.outdoor:
        return LocalizedTexts.outdoor.tr();
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
