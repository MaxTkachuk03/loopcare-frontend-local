import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

FormFieldValidator<String>? emailValidator() {
  return (String? value) => Email.create(value ?? '').swap().toOption().toNullable()?.map(
        empty: (_) => LocalizedTexts.pleaseEnterYourEmailAddress.tr(),
        invalid: (_) => LocalizedTexts.pleaseEnterValidEmailAddress.tr(),
      );
}
