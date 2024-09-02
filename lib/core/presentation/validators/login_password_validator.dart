import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/authentication/domain/login_password/login_password.dart';

FormFieldValidator<String>? loginPasswordValidator() {
  return (String? value) =>
      LoginPassword.create(value ?? '').swap().toOption().toNullable()?.map(
            empty: (_) => LocalizedTexts.pleaseEnterYourPassword.tr(),
          );
}
