import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

String? validateActivityField(String? value) {
  if (value == null || value.isEmpty) {
    return LocalizedTexts.requiredField.tr();
  } else if (value.trim().isEmpty) {
    return LocalizedTexts.requiredField.tr();
  } else if (value.trim().length > 30) {
    return LocalizedTexts.errorActivityMessage.tr();
  }
  return null;
}
