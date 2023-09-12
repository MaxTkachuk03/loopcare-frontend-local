import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

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
