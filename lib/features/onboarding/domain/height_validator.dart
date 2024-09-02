import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/onboarding/domain/height/height.dart';

FormFieldValidator<String>? heightValidator() {
  return (String? value) => Height.create(value ?? '').swap().toOption().toNullable()?.map(
        empty: (_) => LocalizedTexts.enterYourHeight.tr(),
        heightTooSmall: (_) => LocalizedTexts.heightSmall.tr(),
        heightTooLarge: (_) => LocalizedTexts.heightLarge.tr(),
      );
}
