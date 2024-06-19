import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/reg_exp_utils.dart';

class NameValidator {
  NameValidator._();

  static String? validate(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return LocalizedTexts.pleaseEnterYourName.tr();
    }

    if (!RegExp(RegExpUtils.userName).hasMatch(value)) {
      return LocalizedTexts.nameRegexValidationError.tr();
    }

    return null;
  }
}
