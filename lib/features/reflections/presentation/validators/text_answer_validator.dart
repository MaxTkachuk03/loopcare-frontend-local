import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

String? textAnswerValidator(String? value) {
  if (value == null || value.isEmpty) {
    return LocalizedTexts.requiredField.tr();
  } else if (value.trim().isEmpty) {
    return LocalizedTexts.requiredField.tr();
  } else if (value.trim().length > 20000) {
    return LocalizedTexts.errorOpenTextMessage.tr();
  }
  return null;
}
