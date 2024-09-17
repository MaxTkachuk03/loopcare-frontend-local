import 'package:loopcare_frontend/core/presentation/utils/reg_exp_utils.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

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
