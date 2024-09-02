import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

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
