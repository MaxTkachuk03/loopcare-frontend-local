import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/authentication/domain/login_password/login_password.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

FormFieldValidator<String>? loginPasswordValidator() {
  return (String? value) => LoginPassword.create(value ?? '').swap().toOption().toNullable()?.map(
        empty: (_) => LocalizedTexts.pleaseEnterYourPassword.tr(),
      );
}
