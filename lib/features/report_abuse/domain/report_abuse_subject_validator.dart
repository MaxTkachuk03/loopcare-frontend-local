import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

String? reportAbuseSubjectValidator(String? value) {
  if (value == null || value.isEmpty) {
    return LocalizedTexts.requiredField.tr();
  } else if (value.trim().isEmpty) {
    return LocalizedTexts.requiredField.tr();
  } else if (value.trim().length > 30) {
    return LocalizedTexts.errorSubjectMessage.tr();
  }
  return null;
}
