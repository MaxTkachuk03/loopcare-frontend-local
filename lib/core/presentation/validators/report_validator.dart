import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

String? validateReportAbuseField(String? value) {
  if (value == null || value.isEmpty) {
    return LocalizedTexts.requiredField.tr();
  } else if (value.trim().isEmpty) {
    return LocalizedTexts.requiredField.tr();
  } else if (value.trim().length > 500) {
    return LocalizedTexts.errorReportMessage.tr();
  }
  return null;
}

String? validateSubjectAbuseField(String? value) {
  if (value == null || value.isEmpty) {
    return LocalizedTexts.requiredField.tr();
  } else if (value.trim().isEmpty) {
    return LocalizedTexts.requiredField.tr();
  } else if (value.trim().length > 30) {
    return LocalizedTexts.errorSubjectMessage.tr();
  }
  return null;
}
