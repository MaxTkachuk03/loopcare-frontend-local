import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

enum YesNoAnswer {
  yes(value: true),
  no(value: false);

  const YesNoAnswer({required this.value});

  final bool value;
}

extension YesNoAnswerX on YesNoAnswer {
  String get label {
    switch (this) {
      case YesNoAnswer.yes:
        return LocalizedTexts.yes.tr().capitalize();
      case YesNoAnswer.no:
        return LocalizedTexts.no.tr().capitalize();
    }
  }

  bool get boolValue {
    switch (this) {
      case YesNoAnswer.yes:
        return true;
      case YesNoAnswer.no:
        return false;
    }
  }
}
