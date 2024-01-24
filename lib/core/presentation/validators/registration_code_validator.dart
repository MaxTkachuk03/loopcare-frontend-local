import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/authentication/domain/registration_code/registration_code.dart';

FormFieldValidator<String>? registrationCodeValidator() {
  return (String? value) => RegistrationCode.create(value ?? '').swap().toOption().toNullable()?.map(
        empty: (_) => LocalizedTexts.pleaseEnterRegistrationCode.tr(),
        invalid: (_) => LocalizedTexts.pleaseEnterValidRegistrationCode.tr(),
      );
}
