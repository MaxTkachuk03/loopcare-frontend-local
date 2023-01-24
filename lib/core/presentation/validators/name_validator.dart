import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/authentication/domain/name/name.dart';

FormFieldValidator<String>? nameValidator() {
  return (String? value) =>
      Name.create(value ?? '').swap().toOption().toNullable()?.map(
        empty: (_) => LocalizedTexts.pleaseEnterYourName.tr(),
      );
}
