import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/onboarding/domain/height/height.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

FormFieldValidator<String>? heightValidator() {
  return (String? value) => Height.create(value ?? '').swap().toOption().toNullable()?.map(
        empty: (_) => LocalizedTexts.enterYourHeight.tr(),
        heightTooSmall: (_) => LocalizedTexts.onboardingHeightSmall.tr(),
        heightTooLarge: (_) => LocalizedTexts.onboardingHeightLarge.tr(),
      );
}
