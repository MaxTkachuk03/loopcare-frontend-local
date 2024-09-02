import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';

FormFieldValidator<String>? emailValidator() {
  return (String? value) =>
      Email.create(value ?? '').swap().toOption().toNullable()?.map(
            empty: (_) => LocalizedTexts.pleaseEnterYourEmailAddress.tr(),
            invalid: (_) => LocalizedTexts.pleaseEnterValidEmailAddress.tr(),
          );
}
