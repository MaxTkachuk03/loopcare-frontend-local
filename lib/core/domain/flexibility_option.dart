import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum FlexibilityOption {
  more,
}

extension FlexibilityOptionX on FlexibilityOption {
  String get label {
    switch (this) {
      case FlexibilityOption.more:
        return LocalizedTexts.moreFlexibility.tr().capitalize();
    }
  }
}
