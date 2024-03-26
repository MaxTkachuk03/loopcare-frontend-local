import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/onboarding_new/utils/bmi_validator.dart';

enum _BmiExclusionType {
  highBmiYoung(LocalizedTexts.bmiExclusionBodyYounger19HighBmi),
  lowBmiYoung(LocalizedTexts.bmiExclusionBodyYounger19LowBmi),
  highBmiOld(LocalizedTexts.bmiExclusionBodyOlder19HighBmi),
  lowBmiOld(LocalizedTexts.bmiExclusionBodyOlder19LowBmi);

  const _BmiExclusionType(this.text);

  final String text;

  String get lastParagraph => switch(this) {
    lowBmiYoung || lowBmiOld => LocalizedTexts.bmiExclusionBodyLowBmiEnding,
    highBmiYoung || highBmiOld => LocalizedTexts.bmiExclusionBodyHighBmiEnding,
  };
}

_BmiExclusionType _getBmiExclusionTypeFromAgeAndBmi(int age, num bmi) {
  if (age <= BmiValidator.minAllowedAge && bmi < BmiValidator.minValue) {
    return _BmiExclusionType.lowBmiYoung;
  } else if (age <= BmiValidator.minAllowedAge && bmi > BmiValidator.maxValueForYoung) {
    return _BmiExclusionType.highBmiYoung;
  } else if (age > BmiValidator.minAllowedAge && bmi < BmiValidator.minValue) {
    return _BmiExclusionType.lowBmiOld;
  } else {
    return _BmiExclusionType.highBmiOld;
  }
}

class FailedBmiBody extends StatelessWidget {
  const FailedBmiBody({
    super.key,
    required this.age,
    required this.bmi,
  });

  final int age;
  final num bmi;

  @override
  Widget build(BuildContext context) {
    final exclusionType = _getBmiExclusionTypeFromAgeAndBmi(age, bmi);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.w400(
          '${LocalizedTexts.bmiExclusionBodyTitle.tr()}:',
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(height: 10.0),
        CustomText.w600(
          bmi.toStringAsFixed(1),
          style: context.textTheme.headlineLarge,
        ),
        const SizedBox(height: 10.0),
        CustomText.w400(
          exclusionType.text.tr(),
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(height: 20.0),
        CustomText.w400(
          exclusionType.lastParagraph.tr(),
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
