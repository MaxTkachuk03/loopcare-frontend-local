import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum DiabetesTypes {
  typeOne,
  typeTwo,
  no,
}

extension DiabetesTypesX on DiabetesTypes {
  String get label {
    switch (this) {
      case DiabetesTypes.typeOne:
        return LocalizedTexts.typeOne.tr();
      case DiabetesTypes.typeTwo:
        return LocalizedTexts.typeTwo.tr();
      case DiabetesTypes.no:
        return LocalizedTexts.no.tr().capitalize();
    }
  }
}
